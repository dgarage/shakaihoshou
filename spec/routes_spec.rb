# encoding: utf-8

require 'spec_helper'

describe 'Routes' do

  it "main page" do
    visit '/'
    expect( current_path ).to eq( '/' )
  end

  it "blog page" do
    visit '/blog'
    expect( current_path ).to eq( '/blog' )
  end

end
