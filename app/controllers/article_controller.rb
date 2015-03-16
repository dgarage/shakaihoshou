# encoding: UTF-8
class ArticleController < ApplicationController
  include ApplicationHelper

  before_filter :get_header_data
  #before_filter :auth

  def index
  	@articles = get_articles

  	render "article/index"
  end

  def title
  	title = params[:title]
  	article_list = Array.new
  	Dir.glob("#{Rails.root}/app/views/article/*").each do |article|
  		x = article.split("/")[-1]
  		y = x.split(".")[0]
  		if y != "index"
  			article_list << y
  		end
  	end

  	if article_list.include?(title)
  	    render 'article/' + title
  	else
  		redirect_to :action => "index"
  	end
  end
end
