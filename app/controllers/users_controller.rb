class UsersController < ApplicationController
    before_action :authenticate_user, {only: [:index,:logout]}
    before_action :forbid_login_user, {only: [:login_form, :login]}

    def login
        @user = User.find_by(userid: params[:userid])
        if @user && @user.authenticate(params[:password])
            session[:userid] = @user.userid
            flash[:notice] = "ログインしました"
            redirect_to("/index")
        else
            flash[:notice] = "ユーザIDまたはパスワードが間違っています"
            @userid = params[:userid]
            @password = params[:password]
            render("users/login_form")
        end
    end

    def login_form
        @user = User.new
    end

    def index

    end

    def logout
        session[:userid] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/login")
    end
end
