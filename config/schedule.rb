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

set :output, ENV['IMG_NOW_API_SCHEDULE_OUTPUT_LOCATION']
# set :environment, "development"
set :environment, "production"

every '*/30 * * * *' do
	runner "Image.delete_old_images"
	runner "Image.clear_tmp_uploads"
	runner "Image.update_time_until_deletion"
end