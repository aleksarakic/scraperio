# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
root_path = File.expand_path("..", __dir__)

# * * * * * /bin/bash -l -c 'ruby /path_to_project/lib/app.rb >> /path_to_project/cron_log.log 2>&1'
set :output, "#{root_path}/cron_log.log"

every 1.hour do
	command "ruby #{root_path}/lib/app.rb", :environment => 'development'
end

