require 'active_record'
require 'fileutils'

namespace :db do
  @file_name = "data/seed_data.sql"
  @sql_file = File.new(@file_name,"w+")
  @zip_file = File.new("db/seed_data.sql.gz","w") 

  desc "Load seed data"
  task :seed => [:environment] do
    unzip_it if @sql_file.nil?
    conx = db_connection_string
    system("psql #{conx} < data/seed_data.sql")
  end

  desc "Dump and gzip database"
  task :zip => [:environment] do
    conx = db_connection_string
    system("mysqldump #{conx} > data/seed_data.sql")
    zip_it
    remove_sql_file
  end

end

private

def remove_sql_file
    FileUtils.rm [@file_name]
end

def zip_it
	Zlib::GzipWriter.open(@zip_file) do |gzip|
	  gzip << @sql_file.read
	  gzip.close
	end
end

def unzip_it
  File.open(@zip_file) do |f|
    gz = Zlib::GzipReader.new(f)
    @sql_file << gz.read
    gz.close
  end
end

def db_connection_string()
  db_config = ActiveRecord::Base.configurations[RAILS_ENV]
  db_name = db_config["database"]
  db_user = db_config["username"]
  db_pass = (!db_config["password"].nil?) ? (" -W ") : ""
  db_host = (!db_config["host"].nil?) ? (" -h #{db_config["host"]}") : ""
  return "-u #{db_user} #{db_pass} #{db_host} #{db_name} "
end
