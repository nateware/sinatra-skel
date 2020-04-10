# Rakefile
require 'sinatra/activerecord/rake'
require './boot'

require 'csv'
namespace :db do
  desc "Load database from db/data/*.csv files"
  task :import do
    Dir["#{App.settings.root}/db/data/*.csv"].each do |file|
      model = File.basename(file).sub(/\.csv/, '').singularize.camelize.constantize
      puts "Loading #{model} from #{file}"
      model.transaction do
        CSV.foreach(file, headers: true) do |row|
          puts "  #{row.to_h}"
          model.create! row.to_h
        end
      end
    end
  end
end