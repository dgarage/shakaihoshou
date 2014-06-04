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

	def search_by_several_areas
		@results = Array.new
		params[:selected_city].entries{|city, chosen|
			if chosen.to_i == 1
				@results.append Incident.where({:"0" => city})
			end
		}
		# @results = Incident.where({:"0" => params[:area]})
		# @results = Array.new if @results.blank?
		render 'dummy'
	end

	def search_by_one_area

	end
end