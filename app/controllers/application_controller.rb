class ApplicationController < ActionController::API

	respond_to :html, :json

	def test
		render json: {
			foobar: 'barfood'
		}
	end

end
