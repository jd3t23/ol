class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render json: {error: "Record Not Found with that ID", status: 400}, status: :bad_request
  end
end
