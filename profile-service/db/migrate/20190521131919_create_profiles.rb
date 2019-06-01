class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :login
      t.user_id :integer
      t.string :name
      t.string :surname
      t.string :email
      t.string :bio
      t.interger :avatar_id

      t.timestamps
    end
  end
end
