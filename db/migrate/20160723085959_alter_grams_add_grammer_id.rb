class AlterGramsAddGrammerId < ActiveRecord::Migration
  def change
    add_column :grams, :grammer_id, :integer
    add_index :grams, :grammer_id
  end
end
