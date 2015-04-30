class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.integer :column_1
      t.integer :column_2
      t.string :column_3
      t.string :column_4
      t.string :column_5
      t.float :column_6
      t.float :column_7
      t.float :column_8
      t.string :column_9
      t.float :column_10
      t.float :column_11
      t.float :column_12
      t.string :column_13
      t.float :column_14
      t.float :column_15
      t.float :column_16
      t.string :column_17
      t.float :column_18
      t.float :column_19
      t.float :column_19
      t.float :column_20
      t.string :column_21
      t.float :column_22
      t.float :column_23
      t.float :column_24
      t.string :column_25
      t.float :column_26
      t.float :column_27
      t.float :column_28
      t.integer :column_29
      t.float :column_30
      t.string :column_31
      t.string :column_32
      t.text :column_33

      t.timestamps
    end
  end
end
