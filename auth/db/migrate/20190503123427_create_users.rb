class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login
      t.string :hashed_pwd

      t.timestamps
    end
  end
end
