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
      "妊婦（産前産後）" => 16,
      "Unnamed:17" => 17,
      "乳児 0歳-1歳" => 18,
      "就学前、保育園、幼稚園 １歳-６歳" => 19,
      "小学生 ６歳-12歳" => 20,
      "中学生 12歳-15歳" => 21,
      "高校生 15歳-18歳" => 22,
      "高校生以上、15歳-20歳" => 23,
      "大人 20歳-64歳" => 24,
      "高齢者 前期高齢者対象 65歳-74歳" => 25,
      "高齢者 後期高齢者対象 75歳以上" => 26,
      "要介護者" => 27,
      "障がい者" => 28,
      "住宅・店舗" => 29,
      "URL(1)" => 30,
      "URL(2)" => 31,
      "URL(3)" => 32,
      "項目追加（1）" => 33,
      "項目追加（2）" => 34,
      "項目追加（3）" => 35
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
      16 => "妊婦（産前産後）",
      17 => "Unnamed:17",
      18 => "乳児 0歳-1歳",
      19 => "就学前、保育園、幼稚園 １歳-６歳",
      20 => "小学生 ６歳-12歳",
      21 => "中学生 12歳-15歳",
      22 => "高校生 15歳-18歳",
      23 => "高校生以上、15歳-20歳",
      24 => "大人 20歳-64歳",
      25 => "高齢者 前期高齢者対象 65歳-74歳",
      26 => "高齢者 後期高齢者対象 75歳以上",
      27 => "要介護者",
      28 => "障がい者",
      29 => "住宅・店舗",
      30 => "URL(1)",
      31 => "URL(2)",
      32 => "URL(3)",
      33 => "項目追加（1）",
      34 => "項目追加（2）",
      35 => "項目追加（3）",
    }

    # for i, c in enumerate(df.columns): print 'rename_column :institutions, :"%s", :"%s" '%(c.replace(' ','').replace('\n', ''), i)

    return name_hash[column_code.to_i]
  end

  def structure_data(existing_scenes, cities, query)

    all_results = Hash.new
    area_info_by_scene = Hash[existing_scenes.map{|k| [k, Array.new]}]
    shared_info = Hash[existing_scenes.map{|k| [k, Array.new]}]

    @total_count = 0
    existing_scenes.each{|scene|
      
      cities.each{|city| 
        full_query = query.update({:"0" => city, :"2" => scene})
        results = Incident.where(full_query) 
        all_results[city] = results
        @total_count += results.count
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

  def structure_comparison_data(existing_scenes, cities, query)

    all_results = Hash.new
    area_info_by_scene = Hash[existing_scenes.map{|k| [k, Array.new]}]
    shared_info = Hash.new
    cities.each do |city|
      shared_info[city] = Hash[ existing_scenes.map{|k| [k, Array.new]} ]
    end

    @total_count = 0
    existing_scenes.each{|scene|
      
      cities.each{|city| 
        full_query = query.update({:"0" => city, :"2" => scene})
        results = Incident.where(full_query) 
        all_results[city] = results
        @total_count += results.count
      }

      cities.each{|city|
        all_results[city].each{|row| shared_info[city][scene].append convert_sharedinfo_row_to_hash(row) }

        max_rows = (all_results.values.map{|x| x.length}).max
        
        area_info_by_rows = Array.new(max_rows){Hash.new}

        all_results.each_entry{|city, list_of_results|
          list_of_results.each_with_index{ |city_row, index|
            area_info_by_rows[index][city] = convert_cityrow_to_hash(city_row)
          }
        }
        area_info_by_scene[scene] = area_info_by_rows	
      }
      
    }	
    return area_info_by_scene, shared_info	
  end

	def convert_sharedinfo_row_to_hash(row)
		shared_info_row = Hash.new
		shared_info_row["id"] = row[:id]
		shared_info_row["シーン種別(1)"] = row.attributes["2"]
		shared_info_row["一般名称（今後増えてきたものにする）"] = row.attributes["5"]
		shared_info_row["独自（都、国、市町村）の呼称"] = row.attributes["6"]
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
		city_row_hash["乳児 0歳-1歳"] = city_row["18"]
		city_row_hash["就学前、保育園、幼稚園 １歳-６歳"] = city_row["19"]
		city_row_hash["小学生 ６歳-12歳"] = city_row["20"]
		city_row_hash["中学生 12歳-15歳"] = city_row["21"]
		city_row_hash["高校生 15歳-18歳"] = city_row["22"]
		city_row_hash["高校生以上、15歳-20歳"] = city_row["23"]
		city_row_hash["大人 20歳-64歳"] = city_row["24"]
		city_row_hash["高齢者 前期高齢者対象 65歳-74歳"] = city_row["25"]
		city_row_hash["高齢者 後期高齢者対象 75歳以上"] = city_row["26"]
		city_row_hash["ひとり親"] = city_row["15"]
		city_row_hash["妊婦（産前産後）"] = city_row["16"]
		city_row_hash["要介護者"] = city_row["27"]
		city_row_hash["障がい者"] = city_row["28"]
		city_row_hash["住宅・店舗"] = city_row["29"]
		return city_row_hash
	end

	def get_all_cities()
		cities = Incident.all.pluck(:"0").uniq[1..-1]
		cities.delete nil
		return cities
	end

	def get_all_scenes()
		scenes = (Incident.all.pluck(:"2").uniq[1..-1] + Incident.all.pluck(:"3").uniq[1..-1]).uniq
		scenes.delete nil
		return scenes
	end

	def get_all_stuff()
		stuff = Incident.all.pluck(:"5").uniq[1..-1]
		stuff.delete nil
		return stuff
	end

	def get_header_data()
		@all_cities = get_all_cities	
		@all_scenes = get_all_scenes
		@messages = Array.new
	end

  def get_articles
  	@articles = [
      {
      "number" => "003",
      "vol" => "Vol.3", 
      "title" => "23区初！圧倒的なスピードで「“第二子保育料”無料」にふみきった港区の推進力に迫る", 
      "url" => "003_minatokuinterview_1", 
      "description" => '23区で初めて、第二子の保育料無料化に踏み切った港区。他の自治体よりも早く改定料金が発表された理由とは・・・？',
      "time" => '更新日：2015年6月10日',
      "image" => "a003_010.jpg"
      },
      {
      "number" => "002",
      "vol" => "Vol.2", 
      "title" => "出産・育児に優しい金銭的支援23区比較 2015年版", 
      "url" => "002_ikuji23kuhikaku_1", 
      "description" => '各自治体が様々な金銭的支援を用意しています。自分が住んでいる地域のサービスをしっかり把握し、賢く活用していきましょう。',
      "time" => '更新日：2015年4月23日',
      "image" => "a002_11714360.jpg"
      },
  		{
  		"number" => "001",
      "vol" => "Vol.1", 
  		"title" => "子ども・子育て支援「新」制度の問題", 
  		"url" => "001_kodomokosodate_1", 
  		"description" => '2015年4月より開始される「子ども・子育て支援新制度」。そこにはさまざまな落とし穴があることが分かってきました。',
  		"time" => '更新日：2015年3月16日',
  		"image" => "a001_4179217.jpg"
  		},

  	]
  end

  def get_datavisual
    @datavisual = [
      {
      "number" => "002",
      "vol" => "", 
      "title" => "東京23区出産・育児に優しい金銭的支援一覧（2015年4月）", 
      "url" => "002_ikuji23kuhikaku", 
      "description" => '各自治体が様々な金銭的支援を用意しています。一覧で見てみましょう。',
      "time" => '更新日：2015年4月23日',
      "image" => "b002_ikuji23kuhikaku.jpg"
      },
      {
      "number" => "001",
      "vol" => "", 
      "title" => "東京23区待機児童数ランキング（2014年）", 
      "url" => "001_taikijidoranking", 
      "description" => '東京23区待機児童数ランキングを公開しています。',
      "time" => '更新日：2015年1月21日',
      "image" => "b001_taikijidoranking.jpg"
      },

    ]
  end

  def comparison_column_name
    {
      column_1:"通し番号",
      column_2:"エリア",
      column_3:"地域コード",
      column_4:"自治体名",
      column_5:"年齢",
      block_1_1:"区の階層",
      block_1_2:"標準時間保育料（11時間）第一子",
      block_1_3:"標準時間（11時間）第二子",
      block_1_4:"延長保育料（1時間）",
      block_2_1:"区の階層",
      block_2_2:"標準時間保育料（11時間）第一子",
      block_2_3:"標準時間（11時間）第二子",
      block_2_4:"延長保育料（1時間）",
      block_3_1:"区の階層",
      block_3_2:"標準時間保育料（11時間）第一子",
      block_3_3:"標準時間（11時間）第二子",
      block_3_4:"延長保育料（1時間）",
      block_4_1:"区の階層",
      block_4_2:"標準時間保育料（11時間）第一子",
      block_4_3:"標準時間（11時間）第二子",
      block_4_4:"延長保育料（1時間）",
      block_5_1:"区の階層",
      block_5_2:"標準時間保育料（11時間）第一子",
      block_5_3:"標準時間（11時間）第二子",
      block_5_4:"延長保育料（1時間）",
      block_6_1:"区の階層",
      block_6_2:"標準時間保育料（11時間）第一子",
      block_6_3:"標準時間（11時間）第二子",
      block_6_4:"延長保育料（1時間）",
      endcolumn_1:"区の階層数",
      endcolumn_2:"低所得と上限の差",
      endcolumn_3:"第二子割引条件あり",
      endcolumn_4:"第三子割引条件あり",
      extracolumn_1:"賃貸（首都圏賃貸居住用物件の取引動向（2015年01～03月））㎡単価（円）",
      extracolumn_2:"賃貸50㎡家賃",
      extracolumn_3:"330万円＋家賃",
      extracolumn_4:"470万円＋家賃",
      extracolumn_5:"640万円＋家賃",
      extracolumn_6:"930万円＋家賃",
      extracolumn_7:"1,130万円＋家賃",
      extracolumn_8:"上限＋家賃",
      extracolumn_9:"LR賃貸の50〜60㎡の家賃相場（4人世帯想定）",
      extracolumn_10:"330万円＋家賃（園に子ど1人）",
      extracolumn_11:"330万円＋家賃（園に子ども２人１歳違いとする）",
      extracolumn_12:"470万円＋家賃",
      extracolumn_13:"470万円＋家賃（園に子ども２人１歳違いとする）",
      extracolumn_14:"640万円＋家賃",
      extracolumn_15:"640万円＋家賃（園に子ども２人１歳違いとする）",
      extracolumn_16:"930万円＋家賃",
      extracolumn_17:"930万円＋家賃（園に子ども２人１歳違いとする）",
      extracolumn_18:"1,130万円＋家賃",
      extracolumn_19:"1,130万円＋家（園に子ども２人１歳違いとする）",
      extracolumn_20:"上限＋家賃",
      extracolumn_21:"上限＋家賃（園に子ども２人１歳違いとする）",
      last_column:"特筆すべき事"
    }
  end

  def get_column_data
    data = Comparison.all.map{|x| x.attributes.map{|y| y[1]}}
    data.each do |x|
      x.pop(2)
      x.delete_at(0)
    end

    return data
  end

  def convert_from_float_to_yen(number)
    number = number.to_i.to_s
    if number.length > 3
      number = number.insert(-4, ",")
    end
    number = number + "円"
  end
end
