class AddLogin < ActiveRecord::Migration[5.2]
  def change
  	add_column :series, :login, :string
  end
end
