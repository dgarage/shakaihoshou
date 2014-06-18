module ApplicationHelper

	def get_column_code(column_name)
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

		return code_hash[column_name].to_s.to_sym
	end

	def get_column_name(column_code)
		name_hash = {
			0 => "都、国、市町村", # Area
			1 => "管理番号",
			2 => "シーン種別(1)",
			3 => "シーン種別(2)",
			4 => "保障種別(2)",
			5 => "一般名称（今後増えてきたものにする）", 
			6 => "独自（都、国、市町村）の呼称",
			7 => "保障額・保障内容",
			8 => "対象の方",
			9 => "年齢(以上)",
			10 => "年齢(以下)",
			11 => "年齢(偶数・奇数)",
			12 => "女",
			13 => "男",
			14 => "Unnamed:14",
			15 => "ひとり親",
			16 => "妊婦(産前産後)",
			17 => "Unnamed:17",
			18 => "子供(1)乳児",
			19 => "子供(2)就学前、保育園、幼稚園",
			20 => "子供(3)小学生",
			21 => "子供(4)中学生",
			22 => "子供(5)高校生",
			23 => "高齢者(1)前期高齢者対象",
			24 => "高齢者(2)後期高齢者対象",
			25 => "要介護者",
			26 => "障がい者",
			27 => "住宅・店舗",
			28 => "URL(1)",
			29 => "URL(2)",
			30 => "URL(3)",
			31 => "項目追加（1）",
			32 => "項目追加（2）",
			33 => "項目追加（3）"
		}

		# for i, c in enumerate(df.columns): print 'rename_column :institutions, :"%s", :"%s" '%(c.replace(' ','').replace('\n', ''), i)

		return name_hash[column_code.to_i]
	end

	def structure_data(existing_scenes, cities, query)

		all_results = Hash.new
		area_info_by_scene = Hash[existing_scenes.map{|k| [k, Array.new]}]
		shared_info = Hash[existing_scenes.map{|k| [k, Array.new]}]


		existing_scenes.each{|scene|
			
			
			cities.each{|city| 
				full_query = query.update({:"0" => city, :"2" => scene})
				p 'FULLLLLLLL'
				p full_query
				all_results[city] = Incident.where(full_query) 
			}
			
			all_results[cities[0]].each{|row| shared_info[scene].append convert_sharedinfo_row_to_hash(row) }

			max_rows = (all_results.values.map{|x| x.length}).max
			
			area_info_by_rows = Array.new(max_rows){Hash.new}
			
			all_results.each_entry{|city, list_of_results|
				list_of_results.each_with_index{ |city_row, index|
					area_info_by_rows[index][city] = convert_cityrow_to_hash(city_row)
				}
			}
			area_info_by_scene[scene] = area_info_by_rows	
		}	
		return area_info_by_scene, shared_info	
	end

	
	def convert_sharedinfo_row_to_hash(row)
		shared_info_row = Hash.new
		shared_info_row["id"] = row[:id]
		shared_info_row["シーン種別(1)"] = row.attributes["2"]
		shared_info_row["一般名称（今後増えてきたものにする）"] = row.attributes["5"]
		if row.attributes["7"]
			shared_info_row["保障額・内容"] = row.attributes["7"]
		else
			shared_info_row["保障額・内容"] = ""
		end
		return shared_info_row
	end


	def convert_cityrow_to_hash(city_row)
		city_row_hash = Hash.new
		city_row_hash["年齢(以上)"] = city_row["9"]
		city_row_hash["年齢(以下)"] = city_row["10"]				
		city_row_hash["女"] = city_row["12"]
		city_row_hash["男"] = city_row["13"]
		city_row_hash["子供(1)乳児"] = city_row["18"]
		city_row_hash["子供(2)就学前、保育園、幼稚園"] = city_row["19"]
		city_row_hash["子供(3)小学生"] = city_row["20"]
		city_row_hash["子供(4)中学生"] = city_row["21"]
		city_row_hash["子供(5)高校生"] = city_row["22"]
		city_row_hash["高齢者(1)前期高齢者対象"] = city_row["23"]
		city_row_hash["高齢者(2)後期高齢者対象"] = city_row["24"]
		city_row_hash["ひとり親"] = city_row["15"]
		city_row_hash["妊婦(産前産後)"] = city_row["16"]
		city_row_hash["要介護者"] = city_row["25"]
		city_row_hash["障がい者"] = city_row["26"]
		city_row_hash["住宅・店舗"] = city_row["27"]
		return city_row_hash
	end

end
