require 'rails_helper'

RSpec.describe "Businesses", type: :request do

  describe "GET #index" do

    before(:each) do
      @businesses = 5.times.map { FactoryGirl.create(:business) }
      get businesses_path
    end

    it "returns json, with successful status (200)" do
      expect(response).to be_success
      expect(response.content_type).to eq("application/json")
    end

    it 'renders the json response containing all columns from the csv' do
      column_headers = 'id,uuid,name,address,address2,city,state,zip,country,phone,website,created_at'.split(',')
      JSON.parse(response.body).each { |json_response| expect(column_headers-json_response.keys).to be_empty }
    end
  end

  describe "GET #show" do

    context 'on successful request' do

      before(:each) do
        @business = FactoryGirl.create(:business)
        get business_path(id: @business.id)
      end

      it "returns json with successful status (200), when sending existing business id" do
        expect(response).to be_success
        expect(response.content_type).to eq("application/json")
      end

      it 'renders the json response containing all columns from the csv' do
        get business_path(id: @business.id)
        column_headers = 'id,uuid,name,address,address2,city,state,zip,country,phone,website,created_at'.split(',')
        expect(column_headers - JSON.parse(response.body).keys).to be_empty
      end
    end

    it 'returns json with bad request status (400), when sending business id that does not exist' do
      @business = FactoryGirl.create(:business)
      get business_path(id: @business.id+1)
      expect(response).to be_bad_request
      expect(response.content_type).to eq("application/json")
      expect(response.body).to eq('{"error":"Record Not Found with that ID","status":400}')
    end
  end
end
