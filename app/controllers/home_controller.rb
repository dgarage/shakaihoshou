# encoding: UTF-8
class HomeController < ApplicationController
	include ApplicationHelper

	def index
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3', 'test4', 'test5']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}
		@cities = ['世田谷区', '渋谷区', '新宿区', '中野区']
		@scenes = (Incident.all.pluck(:"2").uniq[1..-1] + Incident.all.pluck(:"3").uniq[1..-1]).uniq
		@targets = Array.new
		(18..24).each{|x| @targets.push get_column_name(x)}
		@situations = Array.new
		[15, 16, 25, 26, 27].each{|x| @situations.push get_column_name(x)}
	end

	# def top_search
	# 	@results = Incident.where({:"0" => params[:area], :"2" => params[:shin]})
		
	# 	@column_names = Array.new
	# 	if @results.blank? 
	# 		@results = Array.new
	# 	else
	# 		@results.first.attributes.keys.each{|k|
	# 			@column_names.append get_column_name(k)
	# 		}
	# 	end
	# 	p @column_names
	# 	render 'dummy'
	# end

	def detailed_search
		p params
	end


	def search_by_area
		query_parameters = params[:selected_city]
		
		if query_parameters.instance_of? String
			# Makes sure that the query parameters are in the right format (hash with city as keys and 1/0 as values)
			query_parameters = {query_parameters => "1"}
		end

		@cities = Array.new
		query_parameters.each_entry{|city, chosen|
			if chosen.to_i == 1
				@cities.append city
			end
		}
		
		
		all_results = Hash.new
		
		if params[:scene]
			@existing_scenes = [params[:scene]]
			p 'MOTHER FUCKER'
		else
			@existing_scenes = (Incident.all.pluck(:"2").uniq[1..-1] + Incident.all.pluck(:"3").uniq[1..-1]).uniq
			@existing_scenes.delete nil
		end
		
		@area_info_by_scene = Hash[@existing_scenes.map{|k| [k, Array.new]}]
		@shared_info = Hash[@existing_scenes.map{|k| [k, Array.new]}]

		@existing_scenes.each{|scene|
			@cities.each{|city|
				all_results[city] = Incident.where({:"0" => city, :"2" => scene})
			}
			
			# MAKE SHARED INFO
			all_results[@cities[0]].each{|row|
				shared_info_row = Hash.new
				shared_info_row["id"] = row[:id]
				shared_info_row["シーン種別(1)"] = row.attributes["2"]
				shared_info_row["一般名称（今後増えてきたものにする）"] = row.attributes["5"]
				if row.attributes["7"]
					shared_info_row["保障額・内容"] = row.attributes["7"]
				else
					shared_info_row["保障額・内容"] = ""
				end
				@shared_info[scene].append shared_info_row
			}

			max_rows = (all_results.values.map{|x| x.length}).max
			
			
			area_info_by_rows = Array.new(max_rows){Hash.new}
			
			all_results.each_entry{|city, list_of_results|
				list_of_results.each_with_index{ |city_row, index|
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
					area_info_by_rows[index][city] = city_row_hash
				}


			}
			@area_info_by_scene[scene] = area_info_by_rows	
		}		
		render 'search_results'
	end

	def show_details
		@incident = Incident.find params[:id]
		render 'incident_details'
	end

end