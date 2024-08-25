resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  address_space       = [var.address_space]
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet {
    name = "${var.name}_subnet"
    address_prefixes = [cidrsubnet(var.address_space, 8, 0)]
  }

  depends_on = [var.resource_group_name]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [ var.resource_group_name ]
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = {
    for subnet in azurerm_virtual_network.vnet.subnet : subnet.name => subnet.id
  }

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [ 
    azurerm_virtual_network.vnet,
    azurerm_network_security_group.nsg
  ]
}
