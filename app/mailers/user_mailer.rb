class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def new_registration
        @user = params[:user]
        @url = root_url

        mail(to: @user.email, subject: 'Welcome to My Site!')
    end
end
