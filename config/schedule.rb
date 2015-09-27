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

set :output, "/Users/henryehly/Sites/ios_rails/imgnow/imgnow-api/log/cron_log.log"

set :environment, "development"

# every '* * * * *' do
	# command "ruby -e 'puts \"its \" + Time.now.to_i.to_s'"
# end

# every day at midnight
every '0 0 * * *' do
	# runner "Image.delete_old_images"
	runner "Image.clear_tmp_uploads"
end

# every '* * * * *' do
# 	runner "Image.clear_tmp_uploads"
# end