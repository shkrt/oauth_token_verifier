# OauthTokenVerifier

This library helps to verify oauth2 access tokens, obtained from third party, i.e. mobile application.

## Installation

not released yet...

`gem install oauth_token_verifier`

`gem oauth_token_verifier`

## Configuration

You should configure enabled providers first, only three providers are supported by now

```
OauthTokenVerifier.configure do
  config.enabled_providers = [:google, :facebook, :vk]
end
```

## Usage

`include OauthTokenVerifier`

`verify(:google, 'qweqweqwLKJNlknlknlk343=')`

The response will either return a struct, containing profile info fields, or raise an exception with error explanation

## Development

TODO: Write usage instructions here

## Contributing

TODO: Write usage instructions here

## License

