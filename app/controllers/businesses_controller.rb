class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :update, :destroy]

  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all.offset(offset).limit(limit)
    render json: @businesses
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    render json: @business
  end

  private

    def set_business
      @business = Business.find(params[:id])
    end

    def business_params
      params.require(:business).permit(:uuid, :name, :address, :address2, :city, :state, :zip, :country, :phone, :website, :page)
    end
end
