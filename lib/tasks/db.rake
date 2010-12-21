require 'active_record'
require 'fileutils'

namespace :db do
  @sql_file = "data/seed_data.sql"
  @zip_file = "db/seed_data.sql.gz"

  # @sql_file = File.new("data/seed_data.sql","w+")

  desc "Load seed data"
  task :load => [:environment] do
    unzip_it
    conx = db_connection_string
    system("mysql #{conx} < data/seed_data.sql")
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
  FileUtils.rm [File.new(@sql_file,"w")]
end

def zip_it
  sql_file = File.new(@sql_file,"r")
  zip_file = File.new(@zip_file,"w") 
	Zlib::GzipWriter.open(zip_file) do |gzip|
	  gzip << sql_file.read
	  gzip.close
	end
end

def unzip_it
  return if File::exists?(@sql_file)
  
  sql_file = File.new(@sql_file,"w+")
  zip_file = File.new(@zip_file,"r")
  
  File.open(zip_file) do |f|
    gz = Zlib::GzipReader.new(f)
    sql_file << gz.read
    gz.close
  end
end

def db_connection_string()
  db_config = ActiveRecord::Base.configurations[RAILS_ENV]
  db_name = db_config["database"]
  db_user = db_config["username"]
  db_pass = (!db_config["password"].nil?) ? (" -p ") : ""
  db_host = (!db_config["host"].nil?) ? (" -h #{db_config["host"]}") : ""
  return "-u #{db_user} #{db_pass} #{db_host} #{db_name} "
end
