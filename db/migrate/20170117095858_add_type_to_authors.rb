class AddTypeToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :type, :string
  end
end
