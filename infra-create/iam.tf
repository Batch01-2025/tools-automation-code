resource "aws_iam_role" "main" {
  name = "${var.name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.name}-role"
  }
}
resource "aws_iam_instance_profile" "main" {
  name = "${var.name}-role"
  role = aws_iam_role.main.name

}

resource "aws_iam_policy_attachment" "policy-attch" {
  name       = "${var.name}-policy-attach"
  count      = length(var.policy_name)
  roles      = [aws_iam_role.main.name]
  policy_arn = "arn:aws:iam::aws:policy/${var.policy_name[count.index]}"
}