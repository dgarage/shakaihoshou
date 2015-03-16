# encoding: UTF-8
class ArticleController < ApplicationController
  include ApplicationHelper

  before_filter :get_header_data
  #before_filter :auth

  def index
  	@articles = [
  		{
  		"number" => "001",
      "vol" => "Vol.1", 
  		"title" => "子ども・子育て支援「新」制度の問題", 
  		"url" => "001_kodomokosodate_1", 
  		"description" => '2015年4月より開始される「子ども・子育て支援新制度」。そこにはさまざまな落とし穴があることが分かってきました。',
  		"time" => '更新日：2015年3月16日',
  		"image" => "a001_4179217.jpg"
  		},
  	]

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