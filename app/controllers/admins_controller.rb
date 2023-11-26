class AdminsController < ApplicationController
    before_action :admin_logged_in? , only: [:change_user_status] 
    # method to create admin user
    def create
        params[:user][:type] = "Admin"
        create_user
    end

    # method to block/unblock regular user
    def change_user_status
        if(["block","unblock"].include?(params[:status]))
            reg_user = RegularUser.find_by(id: params[:user_id])
            render json: {success:false, msg:"User does not exists"} && return if reg_user.nil?
            reg_user.update!(status:params[:status])
            render json: {success:true} 
        else
            render json: {success:false}, status: :unprocessable_entity
        end
    end
    private 
        def admin_params
            params.require(:user).permit(:email,:password,:type)
        end
end

