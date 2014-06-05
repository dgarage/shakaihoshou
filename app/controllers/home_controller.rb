# encoding: UTF-8
class HomeController < ApplicationController
	include ApplicationHelper

	def index
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3', 'test4', 'test5']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}
		@cities = ['世田谷区', '渋谷区', '新宿区', '中野区']

	end

	def top_search


		@results = Incident.where({:"0" => params[:area], :"2" => params[:shin]})
		
		@column_names = Array.new
		if @results.blank? 
			@results = Array.new
		else
			@results.first.attributes.keys.each{|k|
				@column_names.append get_column_name(k)
			}
		end
		p @column_names
		render 'search_results'
	end

	def search_by_area
		@results = Array.new

		# Makes sure that the query parameters are in the right format (hash with city as keys and 1/0 as values)
		# if params[:selected_city].class = Hash
		# 	query_parameters = params[:selected_city]
		# else
		# 	query_parameters = {params[:selected_city] => "1"}
		# end

		@shared_info = Array.new


		query_parameters = params[:selected_city]
		# ["病気・けが"].each{|scene|
		p 'ALFSJALSKDJLAKSJD'
		query_parameters.each_entry{|city, chosen|
			if chosen.to_i == 1
				# p "#{city}, #{chosen}"
				@results = Incident.where({:"0" => city})
				@results.each{|row|
					shared_info_row = Hash.new
					p row.attributes["2"]
					shared_info_row["シーン種別(1)"] = row.attributes["2"]
					shared_info_row["一般名称（今後増えてきたものにする）"] = row.attributes["5"]
					shared_info_row["保障額・内容"] = row.attributes["7"]
					@shared_info.append shared_info_row
				}
			end

		}
		# }

		# @results.each{|query_result|
		# 	p query_result.length
		# }

		
		# @results = Incident.where({:"0" => params[:area]})
		# @results = Array.new if @results.blank?
		render 'search_results'
	end

	def search_by_one_area

	end
end