require 'rails_helper'

RSpec.describe "Businesses", type: :request do

  describe "GET #index" do

    before(:each) do
      @businesses = 101.times.map { FactoryGirl.create(:business) }
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

    context 'paginates the response' do

      it 'returns 50 records if limit param is blank' do
        expect(JSON.parse(response.body).length).to eq(50)
      end

      it 'returns number of records in the limit param' do
        get '/businesses?limit=100'
        expect(JSON.parse(response.body).length).to eq(100)
      end

      it 'skips the number of records in the offset param' do
        get '/businesses?offset=100'
        expect(JSON.parse(response.body).length).to eq(1)
        id_of_101st_business = @businesses.map(&:id)[100]
        expect(JSON.parse(response.body).first["id"]).to eq(id_of_101st_business)
      end

      it 'returns the number of records in the limit param and skips the number of records in the offset param' do
        get '/businesses?limit=10&offset=50'
        expect(JSON.parse(response.body).length).to eq(10)
        ids_of_businesses_50_through_60 = @businesses.map(&:id)[50..59]
        expect(JSON.parse(response.body).map { |business_response| business_response["id"] })
                                                                          .to eq(ids_of_businesses_50_through_60)
      end

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
      expect(response.body).to eq('{"error":"Record Not Found With That ID","status":400}')
    end
  end

  describe "GET undefined resource" do 

    it 'returns json with not found status (404)' do
      get '/undefined_resource'
      expect(response).to be_not_found
      expect(response.content_type).to eq("application/json")
      expect(response.body).to eq('{"error":"Resource Not Found","status":404}')
    end

  end
end
