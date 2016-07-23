class AlterGramsAddGrammerId < ActiveRecord::Migration
  def change
    add_column :grams, :user_id, :integer
    add_index :user_id, :integer
  end
end
