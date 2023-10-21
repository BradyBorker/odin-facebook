class UserInformationsController < ApplicationController
    def edit
        @user = User.includes(:user_information).find(params[:user_id])
    end

    def update
    end
end
