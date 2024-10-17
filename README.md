# Terraform AWS Cognito OAuth2

## Overview
This module provides a set of configurations for creating and managing a user pool and its associated settings. Below are the variables that can be configured to customize the behavior of the module.

## Table of Contents
- [Terraform AWS Cognito OAuth2](#terraform-aws-cognito-oauth2)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Inputs](#inputs)
  - [Objects](#objects)
    - [Access Token](#access-token)
    - [Password Policy](#password-policy)
    - [Resource Server](#resource-server)

## Inputs

| Name                                | Type     | Description                                   | Default Value                           | Required |
| ----------------------------------- | -------- | --------------------------------------------- | --------------------------------------- | -------- |
| `name`                              | `string` | The name of the user pool                     | -                                       | yes      |
| `client_name`                       | `string` | The name of the user pool client              | -                                       | yes      |
| `custom_domain`                     | `string` | The custom domain for the user pool           | -                                       | yes      |
| `access_token`                      | `object` | The access token configuration                | See [Access Token](#access-token)       | no       |
| `common_tags`                       | `map`    | Common tags to apply to all resources         | -                                       | yes      |
| `auto_verified_attributes`          | `list`   | The list of attributes that are auto-verified | `["email"]`                             | no       |
| `explicit_auth_flows`               | `list`   | The list of explicit authentication flows     | `["ALLOW_REFRESH_TOKEN_AUTH"]`          | no       |
| `allowed_oauth_flows`               | `list`   | The list of allowed OAuth flows               | `["client_credentials"]`                | no       |
| `callback_urls`                     | `list`   | The list of allowed callback URLs             | `[]`                                    | no       |
| `logout_urls`                       | `list`   | The list of allowed logout URLs               | `[]`                                    | no       |
| [Password Policy](#password-policy) | `object` | The password policy for the user pool         | See [Password Policy](#password-policy) | yes      |
| [Resource Server](#resource-server) | `object` | The scope for the resource server             | See [Resource Server](#resource-server) | yes      |

## Objects

### Access Token

| Name       | Type     | Description             | Default Value | Required |
| ---------- | -------- | ----------------------- | ------------- | -------- |
| `validity` | `number` | Validity based on unity | -             | yes      |
| `unity`    | `string` | Unity of time           | -             | yes      |

### Password Policy
The `password_policy` object defines the settings for password complexity and security for the user pool.

| Name                | Type     | Description                             | Default Value | Required |
| ------------------- | -------- | --------------------------------------- | ------------- | -------- |
| `minimum_length`    | `number` | Minimum length for the password         | `8`           | yes      |
| `require_uppercase` | `bool`   | Requires at least one uppercase letter  | `true`        | yes      |
| `require_lowercase` | `bool`   | Requires at least one lowercase letter  | `true`        | yes      |
| `require_numbers`   | `bool`   | Requires at least one numeric character | `true`        | yes      |
| `require_symbols`   | `bool`   | Requires at least one special character | `true`        | yes      |

### Resource Server
The `resource_server` object defines the scope and resource server settings for the user pool.

| Name         | Type     | Description                            | Required |
| ------------ | -------- | -------------------------------------- | -------- |
| `name`       | `string` | Name of the resource server            | yes      |
| `identifier` | `string` | Identifier for the resource server     | yes      |
| `scopes`     | `list`   | List of scopes for the resource server | yes      |

Each scope within `scopes` is an object with the following fields:

| Name                | Type     | Description              | Required |
| ------------------- | -------- | ------------------------ | -------- |
| `scope_name`        | `string` | Name of the scope        | yes      |
| `scope_description` | `string` | Description of the scope | yes      |