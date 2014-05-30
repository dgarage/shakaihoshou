require 'csv'
desc "Transfers the data that Kikuchisan collected into the db"

task :transfer_data => :environment do
	
	CSV.foreach('db/data.csv', headers:true){ |row|
	hash = row.to_hash
	institution = Institution.new 
	institution.attribute_names.each{ |attribute|
		institution[attribute] = hash[attribute]
	}
	institution.save
	
}
end