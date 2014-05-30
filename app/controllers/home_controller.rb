class HomeController < ApplicationController
	

	def index
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}

	end

	def top_search
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}
		@area_hash[params[:selected_area]] = true
		@p = params
		render 'index'
	end
end