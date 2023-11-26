class ApplicationController < ActionController::API
    def current_user
        @current_user ||= User.find_by(id: session[:id]) if session[:id]
    end

    def logged_in?
        !current_user.nil?
    end

    def log_in(user)
        session[:id] = user.id
    end

    def create_user
        # an already signed in user can not create a user TODO
        forbidden_response && return if logged_in?
        user = User.new(user_params)
        if(user.save)
            render json: {success:true}
        else
            render json:{success:false, msg:user.errors.full_messages}
        end
    end 

    def unauthorized_response
        render json: {success:false, msg: "user not logged in"} , status: 401 
    end

    def forbidden_response
        render json: {success:false}, status: 403
    end

    def resource_not_found_response
        render json: {success:false, msg:"resource not found"}, status: 404
    end

    def admin_logged_in?
        unauthorized_response && return if !logged_in?
        forbidden_response && return if !current_user.admin?
    end

    def regular_user_logged_in?
        unauthorized_response && return if !logged_in?
        forbidden_response && return if !current_user.regular_user?
    end

    private 
        def user_params
            params.require(:user).permit(:email,:password,:type)
        end
end
