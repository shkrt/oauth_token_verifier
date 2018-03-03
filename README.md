# OauthTokenVerifier

[![Gem Version](https://badge.fury.io/rb/oauth_token_verifier.svg)](https://badge.fury.io/rb/oauth_token_verifier)
[![Build Status](https://travis-ci.org/Shkrt/oauth_token_verifier.svg?branch=master)](https://travis-ci.org/Shkrt/oauth_token_verifier)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7458de9e473f4a7188f8b17cdf8806b8)](https://www.codacy.com/app/zxcgpppmnn/oauth_token_verifier?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Shkrt/oauth_token_verifier&amp;utm_campaign=Badge_Grade)

## Motivation

This library's only responsibility is to verify oauth2 access tokens that have been obtained from third party.
No access tokens needed.

Real-world use case:

- You have a mobile application, with users authenticating via oauth2 providers.

With the help of this library you can use oauth2 access tokens to validate the token, verify the user identity and map users' attributes to the custom attributes.

Example of oauth2 flow using this library is shown below:

![alt text](https://github.com/Shkrt/oauth_token_verifier/raw/master/oauth2_flow.png "Flow example")

The depicted workflow consists of the following steps:

1. User clicks OAuth login button at the mobile application interface

2. User is being shown an authorization dialogue from OAuth provider, where he/she approves permissions to access account data

3. Mobile application receives an access token from OAuth2 provider and immediately passes it to backend app

4. Backend application receives the token and makes a request to the OAuth provider

5. Backend application receives info from OAuth provider and does something with it - authenticates the user, creates the user, updates user's data.

## Installation

install manually:

```shell
gem install oauth_token_verifier
```

or using Bundler:

```ruby
# Gemfile

gem 'oauth_token_verifier'
```

## Configuration

```ruby
OauthTokenVerifier.configure do |c|
  ...
end
```

##### Enabled providers

You should configure enabled providers first, only three providers are supported by now

```ruby
c.enabled_providers = [:google, :facebook, :vk]
```

If you try to use the provider that is not in `enabled_providers` list, the `NoProviderFoundError` will be raised.

Then goes separate configuration for each provider

##### name

Name, that will be returned in the resulting Struct. Basically, it's just a custom alias for provider. Each provider
will be given the default name if no alias provided.

```ruby
# provider name to be returned
c.facebook.name = 'fb'
```

##### id_field

Id field from OAuth provider response, that will be used as unique id. The default values are `email` for `Google`,
`id` for `Facebook` and `Vk`.

```ruby
# id field - this used to uniquely identify user
c.facebook.id_field = 'id'
```
##### fields_mapping

Mapping of other returned fields to arbitrary field names.
By default, no fields parameter passed when querying a provider. With this setting configured, the query parameter will
contain the additional parameters to query more information from OAuth provider.
Feel free to add any field supported by the chosen provider, but keeo in mind that not all the fields are available to
query without api tokens.

```ruby
c.facebook.fields_mapping = { first_name: :name }

c.vk.name = 'vkontakte'
c.vk.id_field = 'id'

# here we map vk's sex field to gender, and photo_id field to avatar
c.vk.fields_mapping = { sex: :gender, photo_id: :avatar }

c.google.name = 'google'
c.google.id_field = 'email'
c.google.fields_mapping = { given_name: :first_name, picture: :avatar }
```

##### version

Version is a required parameter for VK provider. Default VK API version 3.0 is depreceted so it is
neccessary to pass `v` parameter explicitly for any API call to VK. Recommended API version is 5.0+.
Version `5.0` is configured in gem by default, but it's possible to override it:

```ruby
c.vk.version = '5.73'
```

For VK API v.3.0 please use `uid` parameter:

```ruby
c.vk.version = '3.0'
c.vk.id_field = 'uid'
```

## Usage

```ruby
include OauthTokenVerifier
```

```ruby
verify(:google, token: 'some_very_long_unreadable_sequence_here')

```

The response will either return a struct, containing profile info fields, or raise an exception with error explanation:

```ruby
=> #<struct OauthTokenVerifier::Providers::Vk::BaseFields
 id=00010101010,
 provider="vk",
 info=#<struct  first_name="John", last_name="Smith">>
```

Example of error response:

 ```ruby
OauthTokenVerifier::TokenVerifier::TokenCheckError: Invalid Value
```
