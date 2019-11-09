require "schedule.rb"

class SchedulesController < ApplicationController
    before_action :authenticate_user, {only: [:create_form,:create,:show]}
    before_action :forbid_login_user, {only: []}

    def create_form
        @schedule = Schedule.new
        # 現在の年、次月、次月の末日を取得
        @currentYear = @schedule.getCurrentYear()
        @nextMonth = @schedule.getNextMonth()
        @lastDay = @schedule.getNextMonthLastDay(@currentyear,@nextMonth)
        # それぞれを数値にキャスト
        @currentYear.to_i
        @nextMonth.to_i
        @lastDay.to_i

        # 有効なユーザリストの取得
        @users = User.where(enrolledFlag: 1)

        # 希望シフトの取得
        @requests = {}
        @users.each do |user|
            #@requests = {"#{user.userid}": Request.where(yeer: @currentYear,month: @nextMonth,userid: user.userid).order(day: "ASC")}
            @requests["#{user.userid}"] = Request.where(year: @currentYear,month: @nextMonth,userid: user.userid).order(day: "ASC")
        end

    end

    def create
        # 登録処理
        @users = User.where(enrolledFlag: 1)
        @users.each do |user|
            for day in 1..params[:lastDay].to_i
                if params[:schedule]["#{user.userid}"]["#{day}"][:timeToIn]["#{day}"]["time(4i)"] != ""
                    @schedule = Schedule.new(
                        year: params[:year],
                        month: params[:month],
                        day: day,
                        timeToIn: params[:schedule]["#{user.userid}"]["#{day}"][:timeToIn]["#{day}"]["time(4i)"] + ':' + params[:schedule]["#{user.userid}"]["#{day}"][:timeToIn]["#{day}"]["time(5i)"] + ":00",
                        timeToOut: params[:schedule]["#{user.userid}"]["#{day}"][:timeToOut]["#{day}"]["time(4i)"] + ':' + params[:schedule]["#{user.userid}"]["#{day}"][:timeToOut]["#{day}"]["time(5i)"] + ":00",
                        userid: user.userid
                    )
                    if @schedule.save
                        flash[:notice] = "保存!"
                    else
                        flash[:notice] = "失敗"
                    end
                end
            end
        end

        if params[:submit_entry]
            redirect_to("/released/#{params[:year]}/#{params[:month]}")
        else
            redirect_to("/unreleased/#{params[:year]}/#{params[:month]}")
        end
    end

    def show
        @year = params[:year].to_i
        @month = params[:month].to_i
        @lastDay = Schedule.new.getNextMonthLastDay(@year,@month)

        # シフトをユーザごとに取得
        @users = User.where(enrolledFlag: 1)
        @schedules = {}
        @users.each do |user|
            @schedules["#{user.userid}"] = Schedule.where(year: @year,month: @month,userid: user.userid).order(day: "ASC")
        end
    end
end
