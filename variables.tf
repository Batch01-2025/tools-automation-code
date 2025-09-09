variable "tool"{
  default = {
    github-runner = {
      instance_type = "t2.small"
      policy_name = "AdministratorAccess"
      ports = {}
      volume-size = 30
    }
    vault = {
      instance_type = "t2.small"
      policy_name = []
      ports = {
        vault = 8200
      }
      volume-size = 15
    }
  }
}