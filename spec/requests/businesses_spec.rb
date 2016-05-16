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
      get business_path(id: @business.id)
    end

    it "returns json, with successful status (200)" do
      expect(response).to be_success
      expect(response.content_type).to eq("application/json")
    end
  end
end
