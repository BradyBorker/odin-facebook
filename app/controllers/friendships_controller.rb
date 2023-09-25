class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def index
        puts 'Inside Index'
    end

    def show
        # Show active friendships and pending friendship invitations
        @active_friendships = current_user.friendships.includes(:friend).where(pending: false)
        @pending_friendships = current_user.inverse_friendships.includes(:user).where(pending: true)
    end

    def create
        @friendship = current_user.friendships.build(friend_id: params[:friend_id], pending: true)
        
        if @friendship
            @friendship.save
            check_for_inverse
            flash[:notice] = 'Invitation Sent' if flash.empty?
        else
            flash[:alert] = 'Invitation Failed To Send'
        end

        redirect_back(fallback_location: root_path)
    end

    def update
        @friendship = Friendship.find(params[:id])

        if @friendship
            @friendship.pending = false
            @friendship.save
            flash[:notice] = 'Friend Invitation Accepted'
            create
        else
            flash[:alert] = 'Failed to Accept Friend Invitation'
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
    end

    private

    def check_for_inverse
        if current_user.inverse_friendships.find_by(user_id: params[:friend_id], pending: false)
            @friendship.pending = false
            @friendship.save
        end
    end
end
