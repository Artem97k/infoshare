class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :login
      t.integer :user_id
      t.string :name
      t.string :surname
      t.string :email
      t.string :bio
      t.integer :avatar_id

      t.timestamps
    end
  end
end
