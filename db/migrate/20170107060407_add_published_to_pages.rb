class AddPublishedToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :published, :boolean
    add_column :pages, :published_at, :datetime
  end
end
