class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.text :status
      t.integer :quota
      t.datetime :start
      t.datetime :end
      t.string :location
      t.string :link_register
      t.datetime :published_at
      t.boolean :published
      t.string :slug
      t.integer :author_id

      t.timestamps
    end
    add_index :events, :slug, unique: true
    add_index :events, :author_id
  end
end
