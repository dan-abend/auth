class SessionsController < ApplicationController

    def new
    end 

    def create
       entered_email = params["email"]
       entered_password = params["password"]

       #checking the email
       @user = User.find_by({email:entered_email})

       if @user #yes, email matches
        #Check password
        if BCrypt::Password.new(@user.password) == entered_password
            #great!
            session["user_id"] = @user.id #using cookies to store user ID of logged in user
            flash[:notice] = "Welcome!"
            redirect_to "/companies"
       else
        # if password didn't match, send them back to the login page
        flash[:notice] = "Passowrd is incorrect"
        redirect_to "/sessions/new"
       end 
    else 
        #email didn't match, send them back to login bpage
        flash[:notice] = "No user with that email address"
        redirect_to "/sessions/new"
    end
end

end

