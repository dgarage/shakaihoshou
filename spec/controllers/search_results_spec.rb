# encoding: utf-8

require 'spec_helper'

describe HomeController do

  it "should respond to :index" do
    get :index
    expect( response ).to be_ok
  end
  
  context 'search by area' do
    it "should redirect on an empty search" do
      get :search_by_area
      expect( response ).to redirect_to( '/page_not_found' )
    end
  end

  context 'comparison_by_area' do
    it "should redirect on an empty search" do
      get :comparison_by_area
      expect( response ).to redirect_to( '/page_not_found' )
    end
  end

  context 'detailed_search' do
    it "should redirect on an empty search" do
      get :detailed_search
      expect( response ).to redirect_to( '/page_not_found' )
    end
  end

  context 'search_by_scene' do
    it "should redirect on an empty search" do
      get :search_by_scene
      expect( response ).to redirect_to( '/page_not_found' )
    end
  end

end
