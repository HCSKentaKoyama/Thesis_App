class RemoveUserIdFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_reference :requests, :user
    add_column :requests, :userid, :string

    remove_reference :schedules, :user
    add_column :schedules, :userid, :string
  end
end
