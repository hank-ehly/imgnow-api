class Api::SessionsController < Devise::SessionsController  

	clear_respond_to
	respond_to :json

	def destroy

		render json: {
			message: 'Signed out successfully.'
		}

	end

end
