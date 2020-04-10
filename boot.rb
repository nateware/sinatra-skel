ENV['APP_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['APP_ENV'])

require 'sinatra/base' # See Gemfile
require 'sinatra/custom_logger'
require 'sinatra/namespace'
require 'sinatra/json'
require 'will_paginate/active_record'

class App < Sinatra::Base
  register Sinatra::Namespace
  register WillPaginate::Sinatra
  # register Sinatra::RespondWith

  register Mustache::Sinatra
  set :mustache, {
    templates: 'views'
  }

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
    after_reload do
      logger.debug 'App reloaded'
    end
  end

  configure :production do
  end

  configure :development, :production do
    # Log to STDOUT because we plan on Docker
    # logger = Logger.new(File.open("#{root}/log/#{environment}.log", 'a'))
    logger = Logger.new(STDOUT)
    set :logger, logger
    STDOUT.sync = true
  end
end

require_all "#{App.settings.root}/app"
