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

  def test
    @datavisual = get_datavisual
    @articles   = get_articles

    @column_names = comparison_column_name.map{|x| x[1]}
    @column_names = @column_names - [
      "通し番号",
      "賃貸（首都圏賃貸居住用物件の取引動向（2015年01～03月））㎡単価（円）",
      "賃貸50㎡家賃",
      "330万円＋家賃",
      "470万円＋家賃",
      "640万円＋家賃",
      "930万円＋家賃",
      "1,130万円＋家賃",
      "上限＋家賃",
      "LR賃貸の50〜60㎡の家賃相場（4人世帯想定）",
      "330万円＋家賃（園に子ど1人）",
      "330万円＋家賃（園に子ども２人１歳違いとする）",
      "470万円＋家賃",
      "470万円＋家賃（園に子ども２人１歳違いとする）",
      "640万円＋家賃",
      "640万円＋家賃（園に子ども２人１歳違いとする）",
      "930万円＋家賃",
      "930万円＋家賃（園に子ども２人１歳違いとする）",
      "1,130万円＋家賃",
      "1,130万円＋家（園に子ども２人１歳違いとする）",
      "上限＋家賃",
      "上限＋家賃（園に子ども２人１歳違いとする）"
    ] 
    @data = Array.new
    raw_data = get_column_data
    raw_data.each do |row|
      row.delete_at(0)
      21.times { row.delete_at(-2) }
      @data << row
    end

    render 'datavisual/test'
  end
end
