class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users,id: :string,primary_key: :userid do |t|
      # :user_idが主キー :string型
      t.string :password_digest,null: false
      t.string :name,null: false
      t.boolean :managerFlag,default: 0   # =>flase
      t.boolean :enrolledFlag, default: 1 # =>true
      t.timestamps
    end
  end
end
