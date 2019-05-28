class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :login
      t.string :name
      t.string :surname
      t.string :email
      t.string :bio
      t.string :avatar_id

      t.timestamps
    end
  end
end
