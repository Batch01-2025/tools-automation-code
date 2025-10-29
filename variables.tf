variable "tool" {

  default = {
    workstation = {
      instance_type = "t3.medium"
      policy_name   = ["AdministratorAccess"]
      ports         = {
        http = 80
        https = 443
        ssh = 22
      }
      volume_size   = 30
    }
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
variable "key_name" {
  default = "ec2-B1key"
}
