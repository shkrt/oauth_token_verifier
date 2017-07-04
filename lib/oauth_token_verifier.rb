require 'net/http'
require 'oauth_token_verifier/version'
require 'oauth_token_verifier/configuration'
require 'oauth_token_verifier/providers/google'
require 'oauth_token_verifier/providers/facebook'
require 'oauth_token_verifier/providers/vk'

module OauthTokenVerifier
  def verify(provider_name, payload)
    TokenVerifier.new(provider_name, payload[:token]).verify_token
  end

  def configure
    yield configuration
  end

  def configuration
    @configuration ||= Configuration.new
  end
  module_function :configuration, :configure

  class TokenVerifier
    attr_reader :token
    attr_accessor :provider

    # TODO: Factor out errors to separate module with inheritance
    class TokenCheckError < StandardError
      def initialize(msg)
        super(msg)
      end
    end

    class NoProviderFoundError < StandardError
      def initialize(msg)
        super(msg)
      end
    end

    def initialize(provider_name, token)
      @provider = find_provider(provider_name).new
      @token = token
    end

    def verify_token
      @provider.verify_token(self)
    end

    private

    def find_provider(name)
      unless OauthTokenVerifier.configuration.enabled_providers.include? name
        raise NoProviderFoundError, "Oauth provider #{name} is not enabled in configuration"
      end

      "OauthTokenVerifier::Providers::#{name.to_s.camelize}".constantize
    end
  end
end
