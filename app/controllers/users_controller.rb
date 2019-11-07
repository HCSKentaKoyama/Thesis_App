class UsersController < ApplicationController
    before_action :authenticate_user, {only: [:index,:logout,:insert,:add_form,:list,:edit,:update]}
    before_action :forbid_login_user, {only: [:login_form, :login]}

    def login
        @user = User.find_by(userid: params[:userid],enrolledFlag: true)
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

    def add_form
        @user = User.new
    end

    def index

    end

    def logout
        session[:userid] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/login")
    end

    def insert
        @user = User.new(
            userid: params[:userid],
            password: params[:password],
            name: params[:name]
        )
        if @user.save
            flash[:notice] = "ユーザ登録が完了しました"
            redirect_to("/index")
        else
            flash[:notice] = "登録できなかったよ"
            @userid = params[:userid]
            @password = params[:password]
            @name = params[:name]
            render("users/add_form")
        end
    end

    def list
        @users = User.all
    end

    def edit
        @user = User.find_by(userid: params[:userid])
    end

    def update
        @user = User.find_by(userid: params[:userid])
        @user.userid = params[:userid]
        @user.password = params[:password]
        @user.name = params[:name]
        @user.enrolledFlag = params[:enrolledFlag]
        if @user.save
            flash[:notice] = "更新しました"
            redirect_to("/list")
        else
            flash[:notice] = "更新できなかったよ"
            redirect_to("/list")
        end
    end
end
