module OauthTokenVerifier
  class Configuration
    attr_accessor :enabled_providers, :google, :vk, :facebook
    ProviderSettings = Struct.new(:fields_mapping, :name, :id_field)

    def initialize
      @enabled_providers = []

      @google = ProviderSettings.new({
        'first_name' => 'given_name',
        'last_name' => 'family_name'
      }, 'google', 'email')

      @vk = ProviderSettings.new({
        'first_name' => 'first_name',
        'last_name' => 'last_name'
      }, 'vk', 'uid')

      @facebook = ProviderSettings.new({
        'first_name' => 'name',
      }, 'facebook', 'id')
    end
  end
end
