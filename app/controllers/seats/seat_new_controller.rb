class Seats::SeatNewController < ApplicationController
  before_action :jwt

  def index
    err_msg = []
    err_msg << '座席番号が入力されていません。' if params[:number].blank?
    err_msg << '座席タイプが入力されていません。' if params[:seat_type].blank?
    render json: {err_msg: err_msg} and return if err_msg.present?

    seat_new = Seat.new(
      number: params[:number],
      seat_type: params[:seat_type],
      shop_id: @jwt[:id]
    )
    seat_new.save!

    render json: {fl_msg: '座席の登録完了しました。'}
  end
end