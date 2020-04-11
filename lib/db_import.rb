require 'csv'

class DbImport
  # Loads a database table from a CSV file
  def self.load_file(file)
    model = File.basename(file).sub(/\.csv/, '').singularize.camelize.constantize
    puts "[DB=#{ENV['APP_ENV']}] Loading #{model} from #{file}"
    model.transaction do
      CSV.foreach(file, headers: true) do |row|
        puts "[DB=#{ENV['APP_ENV']}]  #{row.to_h}"
        model.create! row.to_h
      end
    end
  end

  # Loads database from all CSV files in a directory
  def self.load_all(csv_dir)
    Dir["#{csv_dir}/*.csv"].each do |file|
      load_file(file)
    end
  end
end
