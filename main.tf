resource "aws_cognito_user_pool" "cognito" {
  name = var.name

  password_policy {
    minimum_length    = var.password_policy.minimum_length
    require_uppercase = var.password_policy.require_uppercase
    require_lowercase = var.password_policy.require_lowercase
    require_numbers   = var.password_policy.require_numbers
    require_symbols   = var.password_policy.require_symbols
  }

  auto_verified_attributes = var.auto_verified_attributes
  tags                     = var.common_tags
}

resource "aws_cognito_resource_server" "cognito" {
  user_pool_id = aws_cognito_user_pool.cognito.id
  identifier   = var.resource_server.identifier
  name         = var.resource_server.name
  dynamic "scope" {
    for_each = var.resource_server.scopes
    content {
      scope_name        = scope.value.scope_name
      scope_description = scope.value.scope_description
    }
  }
}

resource "aws_cognito_user_pool_client" "cognito" {
  name                                 = var.client_name
  user_pool_id                         = aws_cognito_user_pool.cognito.id
  access_token_validity                = var.access_token.validity
  token_validity_units {
    access_token = var.access_token.unit
  }
  generate_secret                      = true
  explicit_auth_flows                  = var.explicit_auth_flows
  allowed_oauth_flows                  = var.allowed_oauth_flows
  allowed_oauth_scopes                 = [for scope in var.resource_server.scopes : "${aws_cognito_resource_server.cognito.identifier}/${scope.scope_name}"]
  allowed_oauth_flows_user_pool_client = true
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls
}

resource "aws_cognito_user_pool_domain" "cognito" {
  domain       = var.custom_domain
  user_pool_id = aws_cognito_user_pool.cognito.id
}
