output "user_pool_id" {
  value = aws_cognito_user_pool.cognito.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.cognito[*].id
}

output "client_secret" {
  value     = aws_cognito_user_pool_client.cognito[*].client_secret
  sensitive = true
}

output "domain_name" {
  value = aws_cognito_user_pool_domain.cognito.domain
}
