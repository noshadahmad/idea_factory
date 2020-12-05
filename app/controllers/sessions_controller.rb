class SessionsController < ApplicationController
    def new


    end
    def create
    
        @user = User.find_by_email params[:email]
        if @user && @user.authenticate(params[:password]) 
            session[:user_id] = @user.id
            redirect_to ideas_path, notice: "Logged in"
        else 
            flash[:alert] = "Password or email not matching "
            render :new
        end
    end



    def destroy
        session[:user_id] = nil
        redirect_to ideas_path, notice: "Logged out!"
    end

end
