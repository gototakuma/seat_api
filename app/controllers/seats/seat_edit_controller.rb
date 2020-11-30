class Seats::SeatEditController < ApplicationController
  before_action :jwt
  def index
    if params[:delete_flg]

      seat = Seat.find_by(id: params[:id])

      seat.destroy!

      fl_msg = '削除完了しました。'
    else
      err_msg = []
      err_msg << '座席番号が入力されていません。' if params[:number].blank?
      err_msg << '座席タイプが入力されていません。' if params[:seat_type].blank?
      render json: {err_msg: err_msg} and return if err_msg.present?

      seat = Seat.find_by(id: params[:id])
      render json: {err_msg: ['座席情報が見つかりませんでした。']} and return if seat.blank?

      seat_update = {
        number: params[:number],
        seat_type: params[:seat_type]
      } 
      seat.update!(seat_update)

      fl_msg = '更新完了しました。'
    end
    render json: {fl_msg: fl_msg}
  end
end