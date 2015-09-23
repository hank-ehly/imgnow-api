class Api::ImagesController < ApplicationController

	respond_to :json

	def upload

		f = hex_to_string(params[:image])
		image = Image.new

		File.open('/Users/henryehly/Desktop/test.jpeg', 'wb') do |file|
			file.write(f)
			image.file = File.open('/Users/henryehly/Desktop/test.jpeg', 'r')
			image.user = current_user
			image.save
		end

		render json: {
			url: 'http://192.168.0.10' + image.file.url
		}
		
	end

	# def index
	# 	@images = Image.where(user: current_user)
	# end

	private

	def hex_to_string(hex)
	 	temp = hex.gsub("\s", "");
    ret = []
    (0...temp.size()/2).each{|index| ret[index] = [temp[index*2, 2]].pack("H2")}
    file = String.new
    ret.each { |x| file << x}
    file  
  end
	

end
