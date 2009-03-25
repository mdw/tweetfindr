set :application, "pizzavendingmachines.com"
set :deploy_to, "/var/www/#{application}"
set :user, "vending"

# scm settings
#set :scm, :git
#set :repository,  "git@boca.unfuddle.com:boca/vending.git"
set :repository, "http://boca.unfuddle.com/svn/boca_vend/trunk"
set :scm_user, "cap"
set :scm_pw, "cap1fy"

role :app, "pizzavendingmachines.com"
role :web, "pizzavendingmachines.com"
role :db, "pizzavendingmachines.com", :primary => true

namespace :deploy do
	task :update_code do
		run "svn -q --username #{scm_user} --password #{scm_pw} --force export #{repository} #{deploy_to}"
	end
	task :symlinks do
		system "echo 'symlinks not needed'"
	end
	task :restart do
		system "echo 'restart not needed'"
	end
	task :start do
		run "ruby #{deploy_to}/vend.rb -e production &"
	end
end

