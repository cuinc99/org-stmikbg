class AddViewToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :view, :integer, default: 0
  end
end
