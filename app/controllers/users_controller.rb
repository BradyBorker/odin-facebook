class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.not_friends(current_user.id).includes(:user_information, :received_invitations)
    end

    def show
        @user = User.includes(:user_information).find(params[:id])
        @posts = Post.where(user_id: current_user.id).includes(:likes, user: :user_information, comments: { user: :user_information }).limit(10)
    end

    def edit
        @user = User.find(current_user.id)
    end

    def update
    end
end
