class Seats::SeatInfoController < ApplicationController
  before_action :jwt

  def index
    id =
      params[:shop_id].present? ? params[:shop_id] : @jwt[:id]
    seats = Seat.where(shop_id: id)
    seats = seats.where('number like ?', "%#{params[:number]}%") if params[:number].present?
    seats = seats.where('seat_type like ?', "%#{params[:seat_type]}%") if params[:seat_type].present?
    render json: {err_msg: ['座席情報が見つかりませんでした。']} and return if seats.blank?

    utilization_seats = []
    statistics = {}
    if params[:in_use]
      utilizations = UtilizationTime.where(seat_id: seats.ids, finished_at: nil)
                                    .where.not(started_at: nil)

      utilization_users = []
      utilizations.each {|u| utilization_users << u.user_id if utilization_users.exclude?(u.user_id)}
      users = User.where(id: utilization_users)  
      
      utilizations.each do |u|
        user = users.find{|user| u.user_id == user.id}
        seat = seats.find{|seat| u.seat_id == seat.id}
        utilization_seats << {
          id: u.id,
          user_id: user.id,
          name: user.name,
          number: seat.number,
          seat_type: seat.seat_type,
          started_at: I18n.l(u.started_at, format: :long)
        }
      end

      if params[:rate_flg] 
        seat_rate = seats.size.to_f
        utilization_rate = utilization_seats.size.to_f
        rate = (utilization_rate / seat_rate * 100).floor
        statistics_number = utilization_rate.to_i.to_s + '/' + seat_rate.to_i.to_s
        statistics = {
          rate: rate,
          statistics_number: statistics_number
        }
      end
    end

    if seats.present?
      response = {seats: seats}
      response['utilization_seats'] =
        utilization_seats.present? ? utilization_seats : []
      response = response.merge(statistics) if statistics.present?
      render json: response
    else
      render json: {err_msg: ['座席情報が見つかりませんでした。']}
    end
  end
end