class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :grammer_id
      t.integer :gram_id

      t.timestamps
    end

    add_index :comments, :grammer_id
    add_index :comments, :gram_id
  end
end
