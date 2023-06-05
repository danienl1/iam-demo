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
