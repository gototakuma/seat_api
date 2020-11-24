class Users::UserInfoController < ApplicationController
  def index
    users = User.all
    users = users.where('name like ?', "%#{params[:name]}%") if params[:name].present?
    users = users.where(id: params[:id]) if params[:id].present?

    if users.present?
      render json: {users: users}
    else
      render json: {err_msg: ['顧客情報が存在しませんでした。']}
    end
  end
end