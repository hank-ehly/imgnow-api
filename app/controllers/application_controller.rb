class ApplicationController < ActionController::API

	# before_filter :configure_permitted_parameters, if: :devise_controller?
	respond_to :html, :json

	def test
		render json: {
			foobar: 'barfood'
		}
	end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:account_update) { |u| 
  #     u.permit(:password, :password_confirmation, :current_password) 
  #   }
  # end

end
