# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  file       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Image < ActiveRecord::Base

	mount_uploader :file, ImageUploader
	belongs_to :user

	def self.clear_tmp_uploads
		
		dir = Rails.root.join('public', 'uploads', 'tmp')
		cleared_files = []
		success = false

		puts "Begin: Image.clear_tmp_uploads at " + Time.now.to_s

		Dir.foreach(dir) do |file|
			unless file == '.' || file == '..'
				if File.delete(dir + file)
					success = true
					cleared_files << file
				end
			end
		end

		# Log message
		if cleared_files.empty?
			puts "* Nothing to destroy."
		else
			if success
				puts "* Destroyed (" + cleared_files.count.to_s + ") files:"
				cleared_files.each do |file|
					puts "-- " + file
				end
			end
		end

		puts "End: Image.clear_tmp_uploads at " + Time.now.to_s

	end

	def self.update_time_until_deletion

		number_of_updated_images = 0

		Image.all.each do |image|
			image.time_until_deletion = image.scheduled_deletion_date - Time.now
			if image.save
				number_of_updated_images += 1
			end
		end

		puts "Updated scheduled deletion dates of (" + number_of_updated_images.to_s + ") images at " + Time.now.to_s

	end

	def self.delete_old_images

		puts "Begin: Image.delete_old_images at " + Time.now.to_s

		images_scheduled_for_deletion = []

		# gather all images scheduled for deletion
		Image.all.each do |i|

			# test cases
			is_over_one_minute_old 	   = i.created_at < (Time.now - 1.minute)  	? true : false
			is_over_five_minutes_old 	 = i.created_at < (Time.now - 5.minutes) 	? true : false
			is_over_thirty_minutes_old = i.created_at < (Time.now - 30.minutes) ? true : false
			is_over_thirty_days_old  	 = i.created_at < (Time.now - 30.days) 	 	? true : false

			# add old images to array
			if is_over_thirty_days_old
				images_scheduled_for_deletion << i
			end
			
		end

		unless images_scheduled_for_deletion.empty?
			puts "* " + images_scheduled_for_deletion.count.to_s + " images scheduled for deletion."	
		end

		destroyed_images = []
		success = false

		# delete all images in "old images" array
		images_scheduled_for_deletion.each do |i|

			# dir for old image
			directory_to_delete = Rails.root.join('public', 'uploads', i.id.to_s)

			# destroy record AND directory
			if Dir.exist?(directory_to_delete)
				if i.destroy && Dir.rmdir(directory_to_delete)

					destroyed_images << i
					success = true

				end
			end
		end

		# Log message
		if destroyed_images.empty?
			puts "* Nothing to destroy."
		else 
			if success
				puts "* Destroyed (" + destroyed_images.count.to_s + ") images:"
				destroyed_images.each do |i|
					puts "-- " + i.file.url.to_s
				end
			end
		end

		puts "End: Image.delete_old_images at " + Time.now.to_s

	end # self.delete_old_images


	def self.extend_deletion_date_for_image(id)

		image = Image.find(id)
		success = false
		return_object = {}

		if image.has_already_been_extended
			return_object[:image] = nil
			return_object[:success] = false
		else

			# image.scheduled_deletion_date = Time.now + 30.minutes
			image.scheduled_deletion_date = Time.now + 30.days
		
			image.time_until_deletion = image.scheduled_deletion_date - Time.now
			image.has_already_been_extended = true
			if image.save
				return_object[:success] = true
				return_object[:image] = image
			end
		end

		return return_object

	end

end
