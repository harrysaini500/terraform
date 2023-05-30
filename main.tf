resource "aws_iam_policy" "PolicyTest" {
  name        = var.IAMPolicy
  description = "test - access to source and destination S3 bucket"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
			"s3:GetObject",
			"s3:DeleteObject",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::test-ndgegy4364gdu-source-bucket1/images/*"
      },
      {
        Action = [
			"s3:ListBucket",
        ]
        Effect   = "Allow"
        Resource = [
			"arn:aws:s3:::test-ndgegy4364gdu-source-bucket1",
			"arn:aws:s3:::test-ndgegy4364gdu-source-bucket1/images/*"
		]
      },
      {
        Action = [
			"s3:putObject",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::test-ndgegy4364gdu-destination-bucket1/images/*"
      },
    ]
  })
}



resource "aws_iam_role" "RoleTest" {
  name        = var.IAMRoleName
  description = "test - access to source and destination S3 bucket"

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
}

resource "aws_iam_role_policy_attachment" "PolicyAttach" {
  role       = aws_iam_role.RoleTest.name
  policy_arn = aws_iam_policy.PolicyTest.arn
}