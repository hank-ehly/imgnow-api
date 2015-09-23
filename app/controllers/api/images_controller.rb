class Api::ImagesController < ApplicationController

	respond_to :json

	# def post

	# 	f = hex_to_string(params[:image])
	# 	uploader = ImageUploader.new
	# 	image = Image.new

	# 	File.open('/Users/henryehly/Desktop/test.jpeg', 'wb') do |file|
	# 		file.write(f)
	# 		image.image = File.open('/Users/henryehly/Desktop/test.jpeg', 'r')
	# 		image.user = current_user
	# 		image.save
	# 	end

	# 	render json: {
	# 		url: 'http://10.10.25.142:3000' + image.image.url
	# 	}
		
	# end

	# def index
	# 	@images = Image.where(user: current_user)
	# end

	# def hex_to_string(hex)
	#  	temp = hex.gsub("\s", "");
 #    ret = []
 #    (0...temp.size()/2).each{|index| ret[index] = [temp[index*2, 2]].pack("H2")}
 #    file = String.new
 #    ret.each { |x| file << x}
 #    file  
 #  end

end
