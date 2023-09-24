class FriendshipsController < ApplicationController
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

    def destroy
    end
end
