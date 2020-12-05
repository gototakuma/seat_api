class UtilizationTimes::UtilizationHistoryController < ApplicationController
  before_action :jwt

  def index
    utilizations = UtilizationTime.joins(:seat)
                                  .where(seats: {shop_id: params[:shop_id]})
                                  .where(user_id: @jwt[:id])
                                  .where.not(finished_at: nil)
    render json: {err_msg: '利用履歴が見つかりませんでした。'} and return if utilizations.blank?

    seat_ids = utilizations.pluck(:seat_id).uniq

    seats = Seat.where(id: seat_ids)

    utilizations_history = []
    utilizations.each do |u|
      seat = seats.find{|s| u.seat_id == s.id}
      utilizations_history << {
        utilization_id: u.id,
        seat_id: u.seat_id,
        number: seat.number,
        seat_type: seat.seat_type,
        started_at: I18n.l(u.started_at, format: :long),
        finished_at: I18n.l(u.finished_at, format: :long)
      }
    end

    render json: {utilizations_history: utilizations_history}
  end
end