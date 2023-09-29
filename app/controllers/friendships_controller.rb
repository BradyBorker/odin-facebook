class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def show
        @active_friendships = current_user.friendships.includes(:friend)
        @pending_invitations = current_user.received_invitations.includes(:sender)
    end

    def create
        @friendship = Friendship.create_friendship({ current_user: current_user.id, friend: params[:friend_id] })

        if @friendship
            FriendInvitation.destroy_invitation({ invitation: params[:invitation_id] })
            flash[:notice] = 'Friend added'
        else
            flash[:alert] = 'Friend not added'
        end

        redirect_back(fallback_location: root_path)
    end

    def destroy
    end
end
