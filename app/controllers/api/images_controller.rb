class Api::ImagesController < ApplicationController

	respond_to :json

	def upload

		f = hex_to_string(params[:image])
		image = Image.new

		File.open('/Users/henryehly/Desktop/img.jpeg', 'wb') do |file|
			file.write(f)
			filename = Time.now.to_i;
			image.file = File.open('/Users/henryehly/Desktop/img.jpeg', 'r')
			image.user = User.find_by(email: params[:email])
			image.save
		end

		render json: {
			url: 'http://192.168.0.10:3000' + image.file.url
		}
		
	end

	def index
		if params[:email]
			@images = Image.where(user: User.find_by(email: params[:email]))
			render json: { images: @images }
		end
	end

	def show
		@image = Image.find(params[:id])
		render json: {
			image: @image
		}
	end

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
