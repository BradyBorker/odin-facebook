class MyRegistrationsController < Devise::RegistrationsController
    def create
        super
        if @user.persisted?
            UserMailer.with(user: @user).new_registration.deliver_later
        end
    end
end
