class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.integer :user_id
      t.integer :parent_id
      t.string :content
      t.string :name
      t.string :surname
      t.integer :avatar_id

      t.timestamps
    end
  end
end
