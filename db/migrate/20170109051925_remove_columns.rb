class RemoveColumns < ActiveRecord::Migration[5.0]
  def change
    def self.up
      remove_column :posts, :banner
    end
  end

end
