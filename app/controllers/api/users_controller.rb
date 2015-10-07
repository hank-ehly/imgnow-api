class Api::UsersController < ApplicationController

	# before_action :authenticate_user!
  respond_to :json

  def edit
    @user = current_user
  end

  def update_password
    @user = User.find_by(email: params[:user][:email])

    if @user.update_with_password(user_params)

      # Sign in the user by passing validation in case their password changed
      # sign_in @user, :bypass => true

      render json: { 
        status: :ok,
        message: "ya"
      }

    else
      render json: { errors: @user.errors.full_messages, status: 422 }
    end

  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end

end

# 
# curl  -H "Content-type: application/json" 
#       -H "Accept: application/json" 
#       -X PATCH 
#       -d '{"user":{
#             "email":"default@email.com",
#             "password":"password",
#             "password":"password1",
#             "password_confirmation":"password1"
#             }
#           }' 
#       http://$HOMEIP:3000/api/user/update_password.json
# 