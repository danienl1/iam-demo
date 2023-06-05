resource "aws_iam_role" "dev" {
  name               = "dev"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "dev" {
  name   = "dev-role-policy"
  role   = aws_iam_role.dev.id
  policy = data.aws_iam_policy_document.dev.json
}

resource "aws_iam_role" "infosec" {
  name               = "infosec"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "infosec" {
  name   = "infosec-role-policy"
  role   = aws_iam_role.infosec.id
  policy = data.aws_iam_policy_document.infosec.json
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

// policy docs //

data "aws_iam_policy_document" "dev" {
  statement {
    sid    = "DevAWSAuthMethod"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "iam:GetInstanceProfile",
      "iam:GetUser",
      "iam:GetRole"
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "infosec" {
  statement {
    sid    = "InfosecAWSAuthMethod"
    effect = "Allow"
    actions = [
      "ec2:Describe*",
      "ec2:List*",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:RebootInstances",
      "ec2:TerminateInstances",
      "ec2:RunInstances",
      "iam:CreateUser",
      "iam:DeleteUser",
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:CreateUserPolicy",
      "iam:DeleteUserPolicy",
      "iam:AddUserToGroup",
      "iam:RemoveUserFromGroup",
      "iam:GetGroup"
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "squeezer_iam" {
  statement {
    effect = "Allow"

    actions = [
      "cloudformation:DescribeStacks",
      "cloudformation:CreateStack",
      "cloudformation:DeleteStack",
      "cloudformation:UpdateStack",
      "s3:List*",
      "s3:Get*",
      "apigateway:GET",
      "lambda:List*",
      "lambda:Get*",
      "events:Describe*",
      "events:List*",
      "logs:List*",
      "logs:Describe*",
      "sns:List*",
      "sns:Get*",
      "ses:Get*",
      "ses:List*",
      "iam:ListUsers",
    ]

    resources = ["*"]
  }
}
