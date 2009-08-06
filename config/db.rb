# database tasks: backup and sync
namespace :db do
	desc "dump the database"
	task :backup do
		run "#{appdir}/shared/sql/backup.sh"
	end

	desc "get DB backup from server"
	task :sync do
		system "scp #{user}@#{application}:#{appdir}/shared/sql/tweetfindr.dump.db ./sql/"
	end
end
