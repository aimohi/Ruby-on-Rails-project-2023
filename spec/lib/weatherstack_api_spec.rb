require 'rails_helper'

describe "WeatherstackApi" do
  describe "in case of cache miss" do

    before :each do
      Rails.cache.clear
    end

    it "When HTTP GET returns one entry, it is parsed and returned" do
      stub_request(:get, /.*kumpula/).to_return(body: '', headers: { 'Content-Type' => "application/json" })

    end 

  end
end 