class UtilizationTimes::UtilizationTimeNewController < ApplicationController
  def index
    render json: {err_msg: 'お客様IDを入力してください。'} and return if params[:user_id].blank?

    user = User.find_by(id: params[:user_id])
    render json: {err_msg: 'お客様情報が見つかりませんでした。'} and return if user.blank?

    seat = Seat.find_by(id: params[:seat_id])
    render json: {err_msg: '座席情報が見つかりませんでした。'} and return if seat.blank?

    time = DateTime.now
    if seat.is_use

      utilization = UtilizationTime.where(seat_id: seat.id, user_id: user.id).last
      render json: {err_msg: '利用履歴が見つかりませんでした。お客様IDに間違いがないか再度ご確認お願いします。'} and return if utilization.blank?

      seat.update!(is_use: false)

      utilization.update!(
        finished_at: time,
        updated_at: time
      )

      fl_msg = "#{I18n.l(time, format: :long)}より利用終了しました。"

    else

      seat.update!(is_use: true)

      utilization_time = UtilizationTime.new(
        started_at: time,
        user_id: user.id,
        seat_id: seat.id,
        updated_at: time,
        created_at: time
      )
      utilization_time.save!


      fl_msg = "#{I18n.l(time, format: :long)}より利用開始しました。"

    end

    render json: {fl_msg: fl_msg}
  end
end