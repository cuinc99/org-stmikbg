class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :authors, :type, :jenis
  end
end
