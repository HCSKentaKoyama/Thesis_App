require "date"

class Schedule < ApplicationRecord
    #現在の日付から次月を返す
    def getNextMonth()
        today = Date.today
        return today.months_since(1).mon
    end

    # 現在の年を返す
    def getCurrentYear()
        today = Date.today
        return today.year
    end

    # 次月の末日を返す
    def getNextMonthLastDay(year,month)
        #引数を数値にキャスト
        lastDate = Date.new(year.to_i,month.to_i,-1)
        return lastDate.day
    end

    # 該当年・月のレコードを全て削除する
    def deleteRecodes(year,month)
        Schedule.where(year: year,month: month).delete_all
        return
    end
end
