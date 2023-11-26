class SessionsController < ApplicationController
    def create
        # don't create session if user already logged in 
        forbidden_response && return if logged_in?
        # create session if email exits in db and password is correct
        # if email is upper case code is not working :TODO
        user  = User.find_by_email(params[:user][:email])&.authenticate(params[:user][:password])
        if(user)
            log_in(user)
            render json:{success:true}
        else
            render json:{success:false, msg:"wrong credentialls"} 
        end
    end

    def destroy
        # delete the user id from session and put current_user to nil that is used to check logged_in status
        session.delete(:id) 
        @current_user = nil
        render json: {success:true}
    end
end
