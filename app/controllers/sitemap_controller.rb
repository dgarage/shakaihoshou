# encoding: UTF-8
class SitemapController < ApplicationController
  def index
    render :layout => false, :formats => :xml, :content_type => 'application/xml'
  end
end
