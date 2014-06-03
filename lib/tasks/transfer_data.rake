require 'csv'
desc "Transfers the data that Kikuchisan collected into the db"

task :transfer_data => :environment do
	p 'Transfering data from csv to database'
	CSV.foreach('db/data.csv'){|row| 
		Incident.create Hash[(0...row.length).map{|x| x.to_s.to_sym}.zip(row)]
	}
end