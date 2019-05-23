class RenameUserIdColumnToLogin < ActiveRecord::Migration[5.2]
  def change
	rename_column :profiles, :user_id, :login
  end
end
