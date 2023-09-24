class FriendshipsController < ApplicationController
    def index
    end

    def create
        @friendship = current_user.friendships.build(friend_id: params[:friend_id], pending: true)
        
        if @friendship
            @friendship.save
            flash[:notice] = 'Invitation Sent'
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
        else
            flash[:alert] = 'Failed to Accept Friend Invitation'
        end

        redirect_back(fallback_location: root_path)
    end

    def destroy
    end
end
