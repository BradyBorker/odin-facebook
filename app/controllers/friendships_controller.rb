class FriendshipsController < ApplicationController
    before_action :authenticate_user!
    
    def show
        # Show active friendships and pending friendship invitations
        @active_friendships = current_user.friendships.includes(:friend).where(pending: false)
        @pending_friendships = current_user.friendships.includes(:friend).where(pending: true)
    end

    def create
        @friendship = current_user.friendships.build(friend_id: params[:friend_id], pending: params[:pending_status])
        
        if @friendship
            @friendship.save
            flash[:notice] = 'Invitation Sent' if flash.empty?
        else
            flash[:alert] = 'Invitation Failed To Send'
        end

        redirect_back(fallback_location: root_path)
    end

    def update
        # In the future should change this so the find is based on Friendship id
        @friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)
        
        if @friendship
            @friendship.pending = false
            @friendship.save
            flash[:notice] = 'Friend Invitation Accepted'
            redirect_to(friendships_path(friend_id: params[:friend_id], pending_status: false))
        else
            flash[:alert] = 'Failed to Accept Friend Invitation'
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
    end
end
