class Api::ImagesController < ApplicationController

	respond_to :json

	def create

		f = hex_to_string(params[:image])
		image = Image.new
		timestamp = Time.now.to_i.to_s
		tmp_dir = Rails.root.join('public', 'uploads', 'tmp').to_s

		File.open(tmp_dir + '/' + "#{timestamp}.jpeg", 'wb') do |file|
			file.write(f)
			image.file = File.open(tmp_dir + '/' + "#{timestamp}.jpeg", 'r')
			image.user = User.find_by(email: params[:email])

			image.scheduled_deletion_date = Time.now + 30.minutes
			# image.scheduled_deletion_date = Time.now + 30.days		
			
			image.time_until_deletion = image.scheduled_deletion_date - Time.now
			image.has_already_been_extended = false
			image.save
		end

		render json: { url: image.file.url }
		
	end

	def update
		if params[:id]
			result = Image.extend_deletion_date_for_image(params[:id])
			render json: result
		end
	end

	def index
		if params[:email]
			@images = Image.where(user: User.find_by(email: params[:email])).order(scheduled_deletion_date: :asc)
			render json: { images: @images }
		end
	end

	def show
		@image = Image.find(params[:id])
		render json: { image: @image }
	end

	def destroy
		@image = Image.find(params[:id])
		dir = Rails.root.join('public', 'uploads', @image.id.to_s).to_s
		if Dir.exist?(dir)
			if @image.destroy
				Dir.rmdir(dir)
				render json: { destroyed_image: @image }
			end
		end
	end

	private

	def hex_to_string(hex)
	 	temp = hex.gsub("\s", "");
    ret = []
    (0...temp.size() / 2).each { |i| ret[i] = [temp[i * 2, 2]].pack("H2") }
    file = String.new
    ret.each { |x| file << x }
    file
  end

end
