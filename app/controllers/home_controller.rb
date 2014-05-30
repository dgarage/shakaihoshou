# encoding: UTF-8
class HomeController < ApplicationController
	

	def index
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3', 'test4', 'test5']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}

	end

	def top_search
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3', 'test4', 'test5']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}
		@area_hash[params[:selected_area]] = true
		render 'index'
	end

	def search_by_area
		p params[:area]
		@results = Institution.all
		# @results = Institution.where({"都、国、市町村" => 'け'})
		render 'search_results'
	end
end