class FriendInvitationsController < ApplicationController    
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

    def destroy
    end
end
