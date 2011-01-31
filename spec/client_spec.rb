# encoding: utf-8

require 'spec_helper'
require 'bitrunner/client'

describe Bitrunner::Client do
  include Bitrunner
  
  before do
    @client = Client.new(:api_key => "XOqEAfxj", :api_secret => "uA96CFtJa138E2T5GhKfngml")
    @client.stubs(:nonce).returns("80684843")
    @client.stubs(:timestamp).returns(1237387851)    
  end
  
  it "should be set the configuration options" do
    @client.api_key.should == "XOqEAfxj"
    @client.api_secret.should == "uA96CFtJa138E2T5GhKfngml"
  end
  
  it "should have default paramters" do
    @client.default_parameters.keys.should == [:api_format, :api_key, :api_nonce, :api_timestamp]
  end
  
  it "should generate a query string for an api call" do
    @client.query_string(:text => "démo", :api_format => "xml").should == "api_format=xml&api_key=XOqEAfxj&api_nonce=80684843&api_timestamp=1237387851&text=d%C3%A9mo"
  end
  
  it "should know how to sign api calls" do
    @client.signature(@client.query_string(:text => "démo", :api_format => "xml")).should == "fbdee51a45980f9876834dc5ee1ec5e93f67cb89"
  end
  
  it "should generate a signed query string for an api call" do
    @client.signed_query_string(:text => "démo", :api_format => "xml").should == "api_format=xml&api_key=XOqEAfxj&api_nonce=80684843&api_timestamp=1237387851&text=d%C3%A9mo&api_signature=fbdee51a45980f9876834dc5ee1ec5e93f67cb89"
  end
end