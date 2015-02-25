class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false

      t.timestamps
    end

    add_foreign_key :posts, :users
  end
end