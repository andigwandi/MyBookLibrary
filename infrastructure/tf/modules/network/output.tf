output "vnet_config" {
  value = {
    name = module.vnet.config.name
    id   = module.vnet.config.id
  }
}

output "subnet_web_config" {
  value = {
    name = module.subnet_web.config.name
    id   = module.subnet_web.config.id
  }
}

output "subnet_app_config" {
  value = {
    name = module.subnet_app.config.name
    id   = module.subnet_app.config.id
  }
}

output "subnet_db_config" {
  value = {
    name = module.subnet_db.config.name
    id   = module.subnet_db.config.id
  }
}

