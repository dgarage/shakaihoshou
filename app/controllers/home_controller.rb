# encoding: UTF-8
class HomeController < ApplicationController
	include ApplicationHelper

	def index
		areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3', 'test4', 'test5']
		@area_hash = Hash.new
		areas.each{|area| @area_hash[area] = false}
		@cities = ['中野区', '渋谷区', '新宿区', '中野区', '渋谷区', '新宿区', '中野区', '渋谷区', '新宿区', '中野区', '渋谷区', '新宿区']

	end

	def top_search
		# areas = ['nan', '世田谷区地域社会福祉協議会', '世田谷区', 'test1', 'test2', 'test3', 'test4', 'test5']
		# @area_hash = Hash.new
		# areas.each{|area| @area_hash[area] = false}
		# @area_hash[params[:selected_area]] = true
		# render 'refine'
		p params

		@results = Incident.where({:"0" => params[:area]})
		# @results = Incident.all

		p @results
		p 'COOOEEEEEE'
		# # p @results.first.encoding
		# @results = Institution.all
		# @results = Institution.all
		render 'search_results'
	end

	def search_by_area
		
		@results = Institution.all
		# @results = Institution.where({"都、国、市町村" => params[:area]})
		render 'search_results'
	end
end