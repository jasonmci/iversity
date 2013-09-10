require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'capybara/rspec'

SexySettings.configure do |config|
  config.path_to_default_settings = File.expand_path("config/default.yml", Dir.pwd)
  config.path_to_custom_settings = File.expand_path("config/custom.yml", Dir.pwd)
end

def settings
  SexySettings::Base.instance()
end

Dir[File.join(File.dirname(__FILE__), '..', 'pages', '**', '*.rb')].each{ |f| require f }
Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each{ |f| require f }

include Capybara::DSL

RSpec.configure do |config|
  config.include BusinessActions
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.color_enabled = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

def app_url
  prefix = if settings.app_base_auth_login.nil? || settings.app_base_auth_login.empty?
             ''
           else
             "#{settings.app_base_auth_login}:#{settings.app_base_auth_pass}@"
           end
  app_base_url prefix
end

def app_base_url(prefix=nil)
  "#{settings.app_protocol || 'http'}://#{prefix}#{settings.app_host}"
end

def serial
  a = [('a'..'z').to_a, (0..9).to_a].flatten.shuffle
  "#{Time.now.utc.strftime("%j%H%M%S")}#{a[0..4].join}"
end

class String
  def open(*args)
    as_page_class.open(*args)
  end

  def given
    as_page_class.new
  end

  def as_page_class
    Object.const_get("#{self.capitalize}Page")
  end
end


Capybara.run_server = false
Capybara.app_host = ''
Capybara.default_wait_time = settings.timeout_small
Capybara.ignore_hidden_elements = true
Capybara.visible_text_only = true
Capybara.match = :one
Capybara.exact_options = true

Capybara.default_driver = settings.driver.to_sym
Capybara.javascript_driver = settings.driver.to_sym
