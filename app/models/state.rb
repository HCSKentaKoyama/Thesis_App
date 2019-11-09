class State < ApplicationRecord

    # その年、その月のレコードを削除する
    def deleteRecode(year,month)
        State.where(year: year,month: month).delete_all
        return
    end
end
