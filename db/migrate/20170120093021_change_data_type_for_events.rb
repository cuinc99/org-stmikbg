class ChangeDataTypeForEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :start_time
    remove_column :events, :end_time
    change_column :events, :start, :datetime
    change_column :events, :end, :datetime
    add_column :events, :start_time, :time
  end
end
