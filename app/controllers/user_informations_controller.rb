class UserInformationsController < ApplicationController
    def edit
        @user_information = UserInformation.find_by(user_id: params[:user_id])
    end

    def update
        @user_information = UserInformation.find(params[:id])
        
        if @user_information.update(user_information_params)
            redirect_back fallback_location: root_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def user_information_params
        params.require(:user_information).permit(:first_name, :last_name)
    end
end
