class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, :null => false
      t.string :slug, :null => false
      t.string :title, :null => false
      t.string :subtitle
      t.text :content
      t.boolean :published
      t.date :published_at

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end