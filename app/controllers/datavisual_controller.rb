# encoding: UTF-8
class DatavisualController < ApplicationController
  include ApplicationHelper

  before_filter :get_header_data
  #before_filter :auth

  def index
  	@datavisual = get_datavisual
    @articles = get_articles

  	render "datavisual/index"
  end

  def title
    @articles = get_datavisual
    @articles = get_articles
  	title = params[:title]
  	article_list = Array.new
  	Dir.glob("#{Rails.root}/app/views/datavisual/*").each do |datavisual|
  		x = datavisual.split("/")[-1]
  		y = x.split(".")[0]
  		if y != "index"
  			article_list << y
  		end
  	end

  	if article_list.include?(title)
  	    render 'datavisual/' + title
  	else
  		redirect_to :action => "index"
  	end
  end
end
