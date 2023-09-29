class FriendInvitation < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'


    def self.destroy_invitation(id)
        invitation = FriendInvitation.find(id[:invitation])
        invitation.destroy
    end
end
