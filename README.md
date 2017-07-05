# OauthTokenVerifier

This library helps to verify oauth2 access tokens that have been obtained from third party, i.e. mobile application.

## Installation

install manually:

`gem install oauth_token_verifier`

or using Gemfile:

`gem 'oauth_token_verifier'`

## Configuration

```
OauthTokenVerifier.configure do |c|
  ...
end
```

You should configure enabled providers first, only three providers are supported by now

```
c.enabled_providers = [:google, :facebook, :vk]
```

then goes separate configuration for each provider

```
# provider name to be returned
c.facebook.name = 'facebook'
```

```
# id field - this used to uniquely identify user
c.facebook.id_field = 'id'
```

mapping of other returned fields to arbitrary field names. By default, no fields parameter passed when querying a provider. Feel free to add any field supported by chosen provider

```
c.facebook.fields_mapping = { first_name: :name }

c.vk.name = 'vkontakte'
c.vk.id_field = 'uid'
c.vk.fields_mapping = { sex: :gender, photo_id: :avatar }

c.google.name = 'google'
c.google.id_field = 'email'
c.google.fields_mapping = { given_name: :first_name, picture: :avatar }

```

## Usage

`include OauthTokenVerifier`

`verify(:google, 'qweqweqwLKJNlknlknlk343=')`

The response will either return a struct, containing profile info fields, or raise an exception with error explanation
