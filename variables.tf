variable "tool"{
  default = {
    github-runner = {
      instance_type = "t2.small"
      policy_name = "AdministratorAccess"
      ports = {}
      volume_size = 30
    }
    vault = {
      instance_type = "t2.small"
      policy_name = []
      ports = {
        vault = 8200
      }
      volume_size = 15
    }
  }
}
variable volume_size {
  type = number
}