class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def show
        @active_friendships = current_user.friendships.includes(:friend)
        @pending_invitations = current_user.received_invitations.includes(:sender)
    end

    def create
        # TODO: Update this to build or find
        # TODO: Create Friendship connection in Friendship class method
        # @friendship_current = current_user.friendships.build(friend_id: params[:friend_id])
        # @friendship_friend = @friend.friendships.build(friend_id: current_user.id)
        
        @friendship_connection = Friendship.create_friendship({ current_user: current_user.id, friend: params[:friend_id] })

        if @friendship_connection
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
