class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.integer :user_id
      t.string :name
      t.integer :avatar_id

      t.timestamps
    end
  end
end
