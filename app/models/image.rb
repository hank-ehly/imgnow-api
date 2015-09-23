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

end
