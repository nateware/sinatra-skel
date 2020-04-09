ENV['APP_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['APP_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['APP_ENV']}.sqlite"
)

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

require 'sinatra/base' # See Gemfile
require 'sinatra/custom_logger'
require 'sinatra/namespace'

class App < Sinatra::Base
  register Sinatra::Namespace

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  configure :production do
    # Log to STDOUT because we plan on Docker
    # logger = Logger.new(File.open("#{root}/log/#{environment}.log", 'a'))
    logger = Logger.new(STDOUT)
    set :logger, logger
    STDOUT.sync = true
  end

  configure :development, :production do

  end
end

require_all "#{App.settings.root}/app"
