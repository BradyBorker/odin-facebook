class UserMailer < ApplicationMailer
    default from: 'endersprodigy@gmail.com'

    def new_registration
        @user = params[:user]
        @user_name = @user.user_information.first_name
        @url = root_url

        mail(to: @user.email, subject: 'Welcome to My Site!')
    end
end
