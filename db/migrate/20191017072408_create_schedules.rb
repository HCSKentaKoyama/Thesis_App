class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :year,:limit => 4,null: false
      t.integer :month,:limit => 4,null: false
      t.integer :day,:limit => 4,null: false
      t.time :timeToIn,null: false
      t.time :timeToOut,null: false
      t.references :user
      t.timestamps
    end
  end
end
