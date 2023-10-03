class FriendInvitationsController < ApplicationController    
    def create
        @invitation = current_user.sent_invitations.create(receiver_id: params[:recipient])

        if @invitation
            flash[:notice] = 'Invitation Successfully Sent'
            redirect_back(fallback_location: root_path)
        else
            flash[:alert] = 'Invitation Failed to Sent'
        end
    end
end
