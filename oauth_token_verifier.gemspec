lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth_token_verifier/version'

Gem::Specification.new do |spec|
  spec.name          = 'oauth_token_verifier'
  spec.version       = OauthTokenVerifier::VERSION
  spec.authors       = ['Shkrt']
  spec.email         = ['zxcgpppmnn@gmail.com']

  spec.summary       = 'Oauth2 token verification'
  spec.description   = 'This library provides possibility of verifying oauth2 access tokens obtained from third party'
  spec.homepage      = 'https://github.com/Shkrt/oauth_token_verifier'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
