# application settings
set :application, "tweetfindr.com"
role :app, application
role :web, application

set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :user, "findr"
set :runner, user
set :keep_releases, 6
default_run_options[:pty] = true

# version control
set :scm, :git
set :repository,  "git://github.com/mdw/tweetfindr.git"
set :branch, "master"
set :checkout, "export"
set :git_shallow_clone, 1


namespace :deploy do
#   task :update_code do
#      run "git clone -q #{repository} #{release_path}"
#   end
   task :start, :roles => [:web, :app] do
      sudo "/etc/init.d/thin start"
   end
   
   task :stop, :roles => [:web, :app] do
      sudo "/etc/init.d stop"
   end
   
   task :restart, :roles => [:web, :app] do
      deploy.stop
      deploy.start
   end
   
   task :cold do   # prevent running rake:migrate
      deploy.update
      deploy.start
   end
   
end

