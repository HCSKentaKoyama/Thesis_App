require "request.rb"

class RequestsController < ApplicationController
    before_action :authenticate_user, {only: [:entry_form,:entry]}
    before_action :forbid_login_user, {only: []}

    def entry_form
        @request = Request.new
        # 現在の年、次月、次月の末日を取得
        @currentYear = @request.getCurrentYear()
        @nextMonth = @request.getNextMonth()
        @lastDay = @request.getNextMonthLastDay(@currentyear,@nextMonth)
        # それぞれを数値にキャスト
        @currentYear.to_i
        @nextMonth.to_i
        @lastDay.to_i

        #現在のシフト希望を取得
        @requests = Request.where(userid: @current_user.userid,year: @currentYear,month: @nextMonth).order(day: "ASC")
    end

    def entry
        # 再登録に備えて初期化
        Request.new.deleteAllRecodes(@current_user.userid,params[:year],params[:month])

        # 登録処理
        for day in 1..params[:lastDay].to_i
            if params[:request][:timeToIn]["#{day}"]["time(4i)"] != ""
                @request = Request.new(
                    year: params[:year],
                    month: params[:month],
                    day: day,
                    timeToIn: params[:request][:timeToIn]["#{day}"]["time(4i)"] + ':' + params[:request][:timeToIn]["#{day}"]["time(5i)"] + ":00",
                    timeToOut: params[:request][:timeToOut]["#{day}"]["time(4i)"] + ':' + params[:request][:timeToOut]["#{day}"]["time(5i)"] + ":00",
                    userid: @current_user.userid
                )
                if @request.save
                    flash[:notice] = "保存!"
                else
                    flash[:notice] = "失敗"
                end
            end
        end
        redirect_to("/index")
    end
end
