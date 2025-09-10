variable "tool" {
  description = "Map of tools with instance details"
  type = map(object({
    instance_type = string
    policy_name   = list(string)
    ports         = map(number)
    volume_size   = number
  }))

  default = {
    github-runner = {
      instance_type = "t2.small"
      policy_name   = ["AdministratorAccess"]
      ports         = {}
      volume_size   = 30
    }

    vault = {
      instance_type = "t2.small"
      policy_name   = []
      ports = {
        vault = 8200
      }
      volume_size   = 15
    }
  }
}
