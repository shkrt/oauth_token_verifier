# OauthTokenVerifier

[![Gem Version](https://badge.fury.io/rb/oauth_token_verifier.svg)](https://badge.fury.io/rb/oauth_token_verifier)
[![Build Status](https://travis-ci.org/Shkrt/oauth_token_verifier.svg?branch=master)](https://travis-ci.org/Shkrt/oauth_token_verifier)

## Motivation

This library's only responsibility is to verify oauth2 access tokens that have been obtained from third party.

Real-world use case:

- You have a mobile application, with users authenticating via oauth2 providers.

- The only thing that this mobile app receive from oauth2 provider is an access token

With the help of this library you can use oauth2 access tokens to validate the token, verify the user identity and map users' attributes to the custom attributes.

Example of oauth2 flow using this library is shown below:

![alt text](https://github.com/Shkrt/oauth_token_verifier/raw/master/oauth2_flow.png "Flow example")

The depicted workflow consists of the following steps:

1. User clicks OAuth login button at the mobile application interface

2. User is being shown an authorization dialogue from OAuth provider, where he/she approves permissions to access account data

3. Mobile application receives an access token from OAuth2 provider and immediately passes it to backend app

4. Backend application receives the token and makes a request to the OAuth provider

5. Backend application receives info from OAuth provider and does something with it - authernticates the user, creates the user, updates user's data.

## Installation

install manually:

```shell
gem install oauth_token_verifier
```

or using Gemfile:

```ruby
gem 'oauth_token_verifier'
```

## Configuration

```ruby
OauthTokenVerifier.configure do |c|
  ...
end
```

You should configure enabled providers first, only three providers are supported by now

```ruby
c.enabled_providers = [:google, :facebook, :vk]
```

then goes separate configuration for each provider

```ruby
# provider name to be returned
c.facebook.name = 'facebook'
```

```ruby
# id field - this used to uniquely identify user
c.facebook.id_field = 'id'
```

mapping of other returned fields to arbitrary field names. By default, no fields parameter passed when querying a provider. Feel free to add any field supported by chosen provider

```ruby
c.facebook.fields_mapping = { first_name: :name }

c.vk.name = 'vkontakte'
c.vk.id_field = 'uid'
c.vk.fields_mapping = { sex: :gender, photo_id: :avatar }

c.google.name = 'google'
c.google.id_field = 'email'
c.google.fields_mapping = { given_name: :first_name, picture: :avatar }

```

## Usage

```ruby
include OauthTokenVerifier
```

```ruby
verify(:google, token: 'qweqweqwLKJNlknlknlk343=')
```

The response will either return a struct, containing profile info fields, or raise an exception with error explanation
