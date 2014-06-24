# encoding: UTF-8
class HomeController < ApplicationController
	include ApplicationHelper

	def index
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3', 'test4', 'test5']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}
		# @cities = ['世田谷区', '渋谷区', '新宿区', '中野区']
		@cities = get_all_cities
		
		@scenes = (Incident.all.pluck(:"2").uniq[1..-1] + Incident.all.pluck(:"3").uniq[1..-1]).uniq
		@scenes.delete nil
		
		@targets = Array.new
		(18..24).each{|x| @targets.push get_column_name(x)}
		@targets.delete nil
		
		@situations = Array.new
		[15, 16, 25, 26, 27].each{|x| @situations.push get_column_name(x)}
		@situations.delete nil
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
		query = Hash.new

		if params[:gender] == '女'
			query[:"12"] = "○"
		elsif params[:gender] == '男'
			query[:"13"] = "○"
		end

		@selected_scenes = Array.new
		params[:scene].each_entry{|scene, chosen|
			if chosen.to_i == 1
				@selected_scenes.append scene
			end
		}

		params[:target].each_entry{|target, chosen|
			if chosen.to_i == 1
				query[get_column_code(target)] = "○"
			end
		}

		params[:situation].each_entry{|target, chosen|
			if chosen.to_i == 1
				query[get_column_code(target)] = "○"
			end
		}

		@cities = [params[:city]]
		
		@area_info_by_scene, @shared_info = structure_data(@selected_scenes, @cities, query)

		render 'search_results'
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
		
		if params[:scene]
			@selected_scenes = [params[:scene]]
		else
			@selected_scenes = (Incident.all.pluck(:"2").uniq[1..-1] + Incident.all.pluck(:"3").uniq[1..-1]).uniq
			@selected_scenes.delete nil
		end
		
		@area_info_by_scene, @shared_info = structure_data(@selected_scenes, @cities, {})

		render 'search_results'
	end

	def show_details
		@incident = Incident.find params[:id]
		render 'incident_details'
	end

	def search_by_scene
		@selected_scene = params[:selected_scene]
		@stuff = Incident.all.pluck(:"5").uniq[1..-1]
		@stuffcount = Hash.new
		@stuff.each{|x| 
			count = Incident.where({:"2" => params[:selected_scene], :"5" => x}).count
			@stuffcount[x] = count if count > 0
		}
			# @stuffcount[x] = Incident.where({:"2" => params[:selected_scene], :"5" => x}).count}
		render 'scene_search_step2'
	end

	def search_by_scene_step2
		@search_criteria = params[:search_criteria]
		
		all_cities = Incident.all.pluck(:"0").uniq[1..-1]
		all_cities.delete nil

		@available_cities = Array.new
		all_cities.each{|city| 
			query = @search_criteria.update({:"0" => city})
			@available_cities.append(city) if Incident.where(query) != nil
			}
		
		
		render 'scene_search_step3'
	end

	def search_by_scene_step3
		
		@cities = [params[:search_criteria][:"0"]]
		@selected_scenes = [params[:search_criteria][:"2"]]
		additional_criteria = {"5" => params[:search_criteria][:"5"]}
		
		@area_info_by_scene, @shared_info = structure_data(@selected_scenes, @cities, additional_criteria)
		render 'search_results'
		# render 'dummy'
	end

end