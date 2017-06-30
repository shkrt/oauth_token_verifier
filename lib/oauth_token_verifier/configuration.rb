module OauthTokenVerifier
  class Configuration
    attr_accessor :enabled_providers, :google, :vk, :facebook
    ProviderSettings = Struct.new(:fields_mapping, :request_fields)

    def initialize
      @enabled_providers = []

      @google = ProviderSettings.new({
        'first_name' => 'given_name',
        'last_name' => 'family_name'
      }, nil)

      @vk = ProviderSettings.new({
        'first_name' => 'first_name',
        'last_name' => 'last_name'
      }, nil)

      @facebook = ProviderSettings.new({
        'first_name' => 'name',
      }, nil)
    end
  end
end
