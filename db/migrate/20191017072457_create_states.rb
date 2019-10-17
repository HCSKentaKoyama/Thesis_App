class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.integer :year,:limit => 4,null: false
      t.integer :month,:limit => 4,null: false
      t.integer :status,:limit => 4,default: 2
      t.timestamps
    end
  end
end
