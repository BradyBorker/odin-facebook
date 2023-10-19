class MyRegistrationsController < Devise::RegistrationsController
    def create
        super
        if @user.persisted?
            UserMailer.with(user: @user).new_registration.deliver_later
        end

        Friendship.create(user_id: 1, friend_id: current_user.id)
        Friendship.create(user_id: current_user.id, friend_id: 1)
    end
end
