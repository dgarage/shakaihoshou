require 'csv'
desc "Transfers the data that Kikuchisan collected into the db"

task :transfer_data => :environment do
	code_hash = {
			"都、国、市町村" => 0,
			"管理番号" => 1,
			"シーン種別(1)" => 2,
			"シーン種別(2)" => 3,
			"保障種別(2)" => 4,
			"一般名称（今後増えてきたものにする）" => 5,
			"独自（都、国、市町村）の呼称" => 6,
			"保障額・保障内容" => 7,
			"対象の方" => 8,
			"年齢(以上)" => 9,
			"年齢(以下)" => 10,
			"年齢(偶数・奇数)" => 11,
			"女" => 12,
			"男" => 13,
			"Unnamed:14" => 14,
			"ひとり親" => 15,
			"妊婦(産前産後)" => 16,
			"Unnamed:17" => 17,
			"子供(1)乳児" => 18,
			"子供(2)就学前、保育園、幼稚園" => 19,
			"子供(3)小学生" => 20,
			"子供(4)中学生" => 21,
			"子供(5)高校生" => 22,
			"高齢者(1)前期高齢者対象" => 23,
			"高齢者(2)後期高齢者対象" => 24,
			"要介護者" => 25,
			"障がい者" => 26,
			"住宅・店舗" => 27,
			"URL(1)" => 28,
			"URL(2)" => 29,
			"URL(3)" => 30,
			"項目追加（1）" => 31,
			"項目追加（2）" => 32,
			"項目追加（3）" => 33
		}

	CSV.foreach('db/data.csv', headers:true){ |row|
	hash = row.to_hash
	institution = Institution.new 
	institution.attribute_names.each{ |attribute|
		institution[attribute] = hash[code_hash[attribute]]
	}
	institution.save
	
}
end