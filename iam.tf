resource "aws_iam_role" "dev" {
  name               = "dev"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "dev" {
  name   = "dev-role-policy"
  role   = aws_iam_role.dev.id
  policy = data.aws_iam_policy_document.dev.json
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::883938848113:user/dle"]
    }
  }
}

data "aws_iam_policy_document" "dev" {
  statement {
    sid    = "1"
    effect = "Allow"

    actions = ["ec2:DescribeInstances"]

    resources = ["*"]
  }

  statement {
    sid    = "DevAWSAuthMethod"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "iam:GetInstanceProfile",
      "iam:GetUser",
      "iam:GetRole",
    ]
    resources = ["*"]
  }
}
