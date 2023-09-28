class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def show
        @active_friendships = current_user.friendships.includes(:friend)
        @pending_friendships = current_user.inverse_friendships.includes(:user).where(pending: true)
    end

    def create
        @friend = User.find(params[:friend_id])
        @friendship_current = current_user.friendships.build(friend_id: params[:friend_id])
        @friendship_friend = @friend.friendships.build(friend_id: current_user.id)

        if @friendship_current.save && @friendship_friend.save
            User.destroy_invitation({ invitation: params[:invitation_id], sender: params[:friend_id] })
            flash[:notice] = 'Friend added'
        else
            flash[:alert] = 'Frient not added'
        end

        redirect_back(fallback_location: root_path)
    end

    def destroy
    end
end
