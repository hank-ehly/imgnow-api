class Api::SessionsController < Devise::SessionsController  
	
	respond_to :json

	def destroy

		render json: {
			message: 'Signed out successfully.'
		}

	end

end
