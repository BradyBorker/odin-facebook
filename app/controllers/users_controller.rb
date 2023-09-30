class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        # Not friends or current_user
        @users = User.not_friends(current_user.id).includes(:user_information)
    end
end
