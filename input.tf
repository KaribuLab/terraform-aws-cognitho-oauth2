variable "name" {
  type        = string
  description = "The name of the user pool"
}

variable "custom_domain" {
  type        = string
  description = "The custom domain for the user pool"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
}

variable "auto_verified_attributes" {
  type        = list(string)
  description = "The list of attributes that are auto-verified"
  default     = ["email"]
}

variable "explicit_auth_flows" {
  type        = list(string)
  description = "The list of explicit authentication flows"
  default = [
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]
}

variable "allowed_oauth_flows" {
  type        = list(string)
  description = "The list of allowed OAuth flows"
  default = [
    "client_credentials",
  ]
}

variable "callback_urls" {
  type        = list(string)
  description = "The list of allowed callback URLs"
  default     = []
}

variable "logout_urls" {
  type        = list(string)
  description = "The list of allowed logout URLs"
  default     = []
}

variable "password_policy" {
  type = object({
    minimum_length    = number
    require_uppercase = bool
    require_lowercase = bool
    require_numbers   = bool
    require_symbols   = bool
  })
  description = "The password policy for the user pool"
  default = {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
  }
}

variable "clients" {
  type = list(object({
    name                 = string
    resource_server_name = string
    identifier           = string
    scopes = list(object({
      scope_name        = string
      scope_description = string
    }))
    access_token = object({
      validity = number
      unit     = string
    })
  }))
  description = "The scope for the resource server"
}
