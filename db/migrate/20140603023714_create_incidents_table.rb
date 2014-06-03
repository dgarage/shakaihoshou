
class CreateIncidentsTable < ActiveRecord::Migration
  
  def change
    create_table :incidents do |t|
    	(0..33).each{|x|
    		t.text x.to_s.to_sym
    	}
    end
  end
end