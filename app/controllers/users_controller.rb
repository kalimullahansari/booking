# for regular user
class UsersController < ApplicationController
    def create
        params[:user][:type] = "RegularUser"
        create_user
    end
end