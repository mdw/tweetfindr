# application settings
set :application, "tweetfindr.com"
role :app, "209.123.234.193"
role :web, "209.123.234.193"
role :db, "tweetfindr.com", :primary => true

set :deploy_to, "/var/www/#{application}"
set :user, "findr"
set :keep_releases, 6
default_run_options[:pty] = true

# version control
set :scm, :git
set :repository,  "git://github.com/mdw/twitvend.git"
set :branch, "master"
set :checkout, "export"
set :git_shallow_clone, 1


namespace :deploy do
   task :update_code do
 #     targetdir = Time.now.strftime("%Y%m%d%H%M%S")
 #     releasedir = "#{deploy_to}/releases/#{targetdir}"
 #     run "mkdir #{releasedir}"
      run "git clone -q #{repository} #{release_path}"
   end
   task :symlink do
      run "ln -nfs #{release_path} #{deploy_to}/current"
   end
	task :restart do
		#run "/usr/local/bin/shotgun --server=thin --port=4567 #{current_path}/vend.rb &"
		run "ruby #{deploy_to}/vend.rb -e production &"
	end
end

