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
  end

  describe "GET #show" do

    before(:each) do
      @business = FactoryGirl.create(:business)
    end

    it "returns json with successful status (200), when sending existing business id" do
      get business_path(id: @business.id)
      expect(response).to be_success
      expect(response.content_type).to eq("application/json")
    end

    it 'returns json with bad request status (400), when sending business id that does not exist' do
      get business_path(id: @business.id+1)
      expect(response).to be_bad_request
      expect(response.content_type).to eq("application/json")
      expect(response.body).to eq('{"error":"Record Not Found with that ID","status":400}')
    end
  end
end
