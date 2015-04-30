class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.integer :column_1
      t.string :column_2
      t.integer :column_3
      t.string :column_4
      t.string :column_5
      t.string :block_1_1
      t.float :block_1_2
      t.float :block_1_3
      t.float :block_1_4
      t.string :block_2_1
      t.float :block_2_2
      t.float :block_2_3
      t.float :block_2_4
      t.string :block_3_1
      t.float :block_3_2
      t.float :block_3_3
      t.float :block_3_4
      t.string :block_4_1
      t.float :block_4_2
      t.float :block_4_3
      t.float :block_4_4
      t.string :block_5_1
      t.float :block_5_2
      t.float :block_5_3
      t.float :block_5_4
      t.string :block_6_1
      t.float :block_6_2
      t.float :block_6_3
      t.float :block_6_4
      t.integer :endcolumn_1
      t.float :endcolumn_2
      t.string :endcolumn_3
      t.string :endcolumn_4
      t.float :extracolumn_1
      t.float :extracolumn_2
      t.float :extracolumn_3
      t.float :extracolumn_4
      t.float :extracolumn_5
      t.float :extracolumn_6
      t.float :extracolumn_7
      t.float :extracolumn_8
      t.float :extracolumn_9
      t.float :extracolumn_10
      t.float :extracolumn_11
      t.float :extracolumn_12
      t.float :extracolumn_13
      t.float :extracolumn_14
      t.float :extracolumn_15
      t.float :extracolumn_16
      t.float :extracolumn_17
      t.float :extracolumn_18
      t.float :extracolumn_19
      t.float :extracolumn_20
      t.float :extracolumn_21
      t.text :last_column

      t.timestamps
    end
  end
end
