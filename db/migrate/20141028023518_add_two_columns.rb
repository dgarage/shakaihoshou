class AddTwoColumns < ActiveRecord::Migration
  def change
  	add_column :incidents, :"34", :text
  	add_column :incidents, :"35", :text 
  end
end
