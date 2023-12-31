class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.not_friends(current_user.id).includes(:user_information, :received_invitations)
    end

    def show
        @user = User.includes(:user_information).find(params[:id])
        @posts = Post.where(user_id: @user.id).includes(:likes, user: :user_information, comments: { user: :user_information }, image_attachment: :blob).limit(10)
    end

    def edit
        @user = User.find(current_user.id)
    end

    def update
        @user = User.find(current_user.id)
        @user.profile_picture.attach(params[:user][:profile_picture]) unless params[:user].nil?

        if @user.save
            redirect_to user_path(@user)
        else
            render :edit
        end
    end
end
