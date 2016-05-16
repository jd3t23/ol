class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def limit
    params[:limit] || 50
  end

  def offset
    params[:offset] || 0
  end

  def resource_not_found
    render json: { error: "Resource Not Found", status: 404 }, status: :not_found
  end

  private

  def record_not_found
    render json: { error: "Record Not Found With That ID", status: 400 }, status: :bad_request
  end
end
