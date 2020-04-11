# Rakefile
require 'sinatra/activerecord/rake'
require './boot'
require 'rake/testtask'

task default: "test"
desc "Run test suite (loads DB/etc)"
task :test do
  sh 'rake db:test:prepare run_tests APP_ENV=test RAILS_ENV=test' 
end

Rake::TestTask.new do |task|
  task.name = :run_tests
  task.ruby_opts << '-r./boot' # load the app
  task.ruby_opts << '-r./test/test_helper'
  task.ruby_opts << '-W0'
  task.pattern = 'test/**/*_test.rb'
  task.verbose = true
end

require './lib/db_import'
namespace :db do
  desc "Load database from db/data/*.csv files"
  task :import do
    DbImport.load_all("#{App.settings.root}/db/data")
  end
end
