class Seats::SeatInfoController < ApplicationController
  before_action :jwt

  def index
    seats = Seat.where(shop_id: @jwt[:id])
    seats = seats.where('number like ?', "%#{params[:number]}%") if params[:number].present?
    seats = seats.where('seat_type like ?', "%#{params[:seat_type]}%") if params[:seat_type].present?

    if seats.present?
      render json: {seats: seats}
    else
      render json: {err_msg: ['座席情報が見つかりませんでした。']}
    end
  end
end