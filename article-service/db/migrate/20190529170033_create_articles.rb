class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.integer :series_id, :default => 0
      t.string :name
      t.string :content

      t.timestamps
    end
  end
end
