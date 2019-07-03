class AddLogin < ActiveRecord::Migration[5.2]
  def change
  	add_column :articles, :login, :string
  end
end
