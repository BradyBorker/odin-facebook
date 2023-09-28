class FriendInvitationsController < ApplicationController
    def new
    end
    
    def create
        @invitation = current_user.sent_invitations.build(receiver_id: params[:recipient], pending: true)

        if @invitation.save
            flash[:notice] = 'Invitation Successfully Sent'
            redirect_back(fallback_location: root_path)
        else
            flash[:alert] = 'Invitation Failed to Sent'
            render :new
        end
    end

    def update
        @invitation = FriendInvitation.find(id: params[:id])
        @invitation.pending = false

        if @invitation.save
            redirect_to controller: :friendships, action: :create
        else
            flash[:alert] = 'Unable to Accept Invitation'
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
    end
end
