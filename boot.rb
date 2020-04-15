ENV['APP_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['APP_ENV'])

require 'will_paginate/active_record'

class App < Sinatra::Base
  register Sinatra::Namespace
  register WillPaginate::Sinatra
  # register Sinatra::RespondWith
  helpers Sinatra::Param

  register Mustache::Sinatra
  set :mustache, {
    templates: 'views'
  }

  configure :development do
    register Sinatra::Reloader
    after_reload do
      logger.debug "App reloaded"
    end
  end

  configure :production do
  end

  configure do
    # Log to STDOUT because we plan on Docker
    # logger = Logger.new(File.open("#{root}/log/#{environment}.log", 'a'))
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development? or test?
    set :logger, logger
    STDOUT.sync = true
  end
end

# leverage autoloading magic
ActiveSupport::Dependencies.autoload_paths = [
  "#{App.settings.root}/app/models",
  "#{App.settings.root}/app/helpers"
]
Dir["#{App.settings.root}/app/routes/*.rb"].each{|f| require f }

# End with this
App.logger.info "App bootstrapped with APP_ENV=#{App.settings.environment}"