require "rails_helper"

RSpec.describe BusinessesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/businesses").to route_to("businesses#index")
    end

    it "routes to #show" do
      expect(:get => "/businesses/1").to route_to("businesses#show", :id => "1")
    end
  end
end
