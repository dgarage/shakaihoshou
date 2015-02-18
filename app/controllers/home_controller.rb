# encoding: UTF-8
class HomeController < ApplicationController
  include ApplicationHelper

  before_filter :get_header_data
  #before_filter :auth

  def index
    @targets = Array.new
    (18..26).each{|x| @targets.push get_column_name(x)}
    @targets.delete nil
    
    @situations = Array.new
    [15, 16, 27, 28, 29,].each{|x| @situations.push get_column_name(x)}
    @situations.delete nil
  end

  def search_by_area
    query_parameters = params[:selected_city]
    if query_parameters.nil?
      redirect_to :page_not_found
    else

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
        @selected_scenes = get_all_scenes
      end
      
      @area_info_by_scene, @shared_info = structure_data(@selected_scenes, @cities, {})

      render 'search_results'

    end
  end

  def comparison_by_area
    query_parameters = params[:selected_city]
    if query_parameters.nil?
      redirect_to :page_not_found
    else

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
        @selected_scenes = get_all_scenes
      end
      
      @area_info_by_scene, @shared_info = structure_comparison_data(@selected_scenes, @cities, {})

      @row_length = Hash.new
      @selected_scenes.each do |scene|
        @row_length[scene] = [@shared_info[@cities[0]][scene].length, @shared_info[@cities[1]][scene].length].max
      end

      render 'comparison_search_results'

    end
  end

  def detailed_search
    if params[:scene].nil? || params[:gender].nil? || params[:situation] || params[:city]
      redirect_to :page_not_found
    else

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

      #params[:target].each_entry{|target, chosen|
      #	if chosen.to_i == 1
      #		query[get_column_code(target)] = "○"
      #	end
      #}

      params[:situation].each_entry{|target, chosen|
        if chosen.to_i == 1
          query[get_column_code(target)] = "○"
        end
      }

      @cities = [params[:city]]
      
      @area_info_by_scene, @shared_info = structure_data(@selected_scenes, @cities, query)

      render 'search_results'

    end
  end

  def show_details
    @incident = Incident.find params[:id]
    render 'incident_details'
  end

  def search_by_scene
    if params[:selected_scene].nil?
      redirect_to :page_not_found
    else
      @selected_scene = params[:selected_scene]
      @stuff = get_all_stuff
      @stuffcount = Hash.new

      #p @stuff
      #test = @stuff.sort!
      #p test

      @stuff.each{|x| 
        count = Incident.where({:"2" => params[:selected_scene], :"5" => x}).count
        @stuffcount[x] = count if count > 0
      }

      render 'scene_search_step2'
    end
  end

  def search_by_scene_step2
    @search_criteria = params[:search_criteria]
    
    all_cities = get_all_cities
    
    @available_cities = Array.new
    all_cities.each{|city| 
      query = @search_criteria.update({:"0" => city})
      @available_cities.append(city) if Incident.where(query) != []
      }
    
    render 'scene_search_step3'
  end

  def search_by_scene_step3
    @cities = [params[:search_criteria][:"0"]]
    @selected_scenes = [params[:search_criteria][:"2"]]
    additional_criteria = {"5" => params[:search_criteria][:"5"]}
    
    @area_info_by_scene, @shared_info = structure_data(@selected_scenes, @cities, additional_criteria)
    render 'search_results'
  end

  def page_not_found
    render 'page_not_found'
  end

  private

  def auth
    if (Rails.env != "development") && (Rails.env != "test")
      authenticate_or_request_with_http_basic do |user,pass|
        user == 'kuyakusho' && pass == 'dgebisuminami357'
      end
    end
  end

end
