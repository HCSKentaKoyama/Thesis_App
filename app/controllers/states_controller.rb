require "state.rb"

class StatesController < ApplicationController
    before_action :authenticate_user, {only: [:create_form,:create]}
    before_action :forbid_login_user, {only: []}

    def released
        # 再登録に備えて初期化
        State.new.deleteRecode(params[:year],params[:month])

        @state = State.new(
            year: params[:year],
            month: params[:month],
            status: 1
        )
        if @state.save
            flash[:notice] = "保存!"
        else
            flash[:notice] = "失敗"
        end
        redirect_to("/")
    end

    def unreleased
        # 再登録に備えて初期化
        State.new.deleteRecode(params[:year],params[:month])

        @state = State.new(
            year: params[:year],
            month: params[:month],
            status: 3
        )
        if @state.save
            flash[:notice] = "保存!"
        else
            flash[:notice] = "失敗"
        end
        redirect_to("/")
    end

end
