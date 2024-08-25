resource "azurerm_network_interface" "nic" {
  count               = length(var.subnets)
  name                = "${var.name}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnets[count.index]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip ? azurerm_public_ip.pip[count.index].id : null
  }
}

resource "azurerm_public_ip" "pip" {
  count               = var.public_ip ? length(var.subnets) : 0
  name                = "${var.name}-pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = length(var.subnets)
  name                = "${var.name}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  tags = var.tags
}
