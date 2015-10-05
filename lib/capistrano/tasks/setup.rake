namespace :setup do
	desc "Upload linked_files to server"
	task :upload_linked_files do
	  on roles(:app) do
	    execute "mkdir -p #{shared_path}/config"
	    upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
	    upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
	    upload! StringIO.new(File.read("config/initializers/devise.rb")), "#{shared_path}/config/initializers/devise.rb"
	    upload! StringIO.new(File.read("config/initializers/secret_token.rb")), "#{shared_path}/config/initializers/secret_token.rb"
	  end
	end
end