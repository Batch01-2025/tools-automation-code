module "create-infra-tool" {
  for_each        = var.tool
  source          = "./infra-create"
  name            = each.key
  instance_type   = each.value["instance_type"]
  ports           = each.value["ports"]
  policy_name     = each.value["policy_name"]
  # volume_size     = each.value["volume_size"]
}