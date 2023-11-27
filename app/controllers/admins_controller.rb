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
            reg_user = RegularUser.find_by(id: params[:id])
            resource_not_found_response && return if reg_user.nil?
            reg_user.update!(status:params[:status])
            render json: {success:true} 
        else
            render json: {success:false, msg:"Allowed status only block and unblock"}, status: :unprocessable_entity
        end
    end
end

