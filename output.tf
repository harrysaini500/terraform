output "IAMPolicy" {
    value = aws_iam_policy.PolicyTest.name  
}

output "IAMRole" {
    value = aws_iam_role.RoleTest.name  
}