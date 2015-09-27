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

		Dir.foreach(dir) do |file|
			unless file == '.' || file == '..'

				File.delete(dir + file)

			end
		end

	end

	def self.delete_old_images

		images_scheduled_for_deletion = []

		# gather all images scheduled for deletion
		Image.all.each do |i|

			# test cases
			is_over_one_minute_old 	 = i.created_at < (Time.now - 1.minute)  ? true : false
			is_over_five_minutes_old = i.created_at < (Time.now - 5.minutes) ? true : false
			is_over_thirty_days_old  = i.created_at < (Time.now - 30.days) 	 ? true : false

			# add old images to array
			if is_over_one_minute_old
				images_scheduled_for_deletion << i
			end

		end

		# delete all images in "old images" array
		images_scheduled_for_deletion.each do |i|

			# dir for old image
			directory_to_delete = Rails.root.join('public', 'uploads', i.id.to_s)

			# destroy record AND directory
			if Dir.exist?(directory_to_delete)
				i.destroy
				Dir.rmdir(directory_to_delete)
			end

		end

	end # delete_old_images

end
