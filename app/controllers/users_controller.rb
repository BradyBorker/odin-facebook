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
        @user = User.find(current_user.id)
        @user.profile_picture.attach(params[:user][:profile_picture]) unless params[:user].nil?

        if @user.save
            redirect_to user_path(@user)
            #render turbo_stream:
            #    turbo_stream.replace('profile-picture',
            #        partial: 'users/profile_picture',
            #        locals: { user: @user })
        else
            render :edit
        end
    end
end
