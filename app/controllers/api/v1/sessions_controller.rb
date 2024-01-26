# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      before_action :sign_in_params, only: :create
      before_action :load_user, only: :create

      def create
        if @user.valid_password?(sign_in_params[:password])
          sign_in 'user', @user
          render json: {
            messages: 'Signed In Successfully',
            is_success: true,
            data: { user: @user }
          }, status: :ok
        else
          render json: {
            messages: 'Signed In Failed - Unauthorized',
            is_success: false,
            data: {}
          }, status: :unauthorized
        end
      end

      def destroy
        sign_out(current_user)
      end

      private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end

      def load_user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
        return @user if @user

        render json: {
          messages: 'Cannot get User',
          is_success: false,
          data: {}
        }, status: :not_found
      end
    end
  end
end
