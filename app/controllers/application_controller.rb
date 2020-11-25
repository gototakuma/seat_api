class ApplicationController < ActionController::API
  rescue_from NameError, with: :name_error

  private

  def name_error(e)
    render json: {err_msg: ["NameError: #{e}"]}
  end
end
