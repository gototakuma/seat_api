class ApplicationController < ActionController::API
  rescue_from NameError, with: :name_error

  private

  def name_error(e)
    render json: ["NameError: #{e}"]
  end
end
