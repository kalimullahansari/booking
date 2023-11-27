require 'date'
class Reservation < ApplicationRecord
    belongs_to :regular_user
    belongs_to :admin, optional:true
    # admin_id will be added only on update
    enum status:{pending:0,confirmed:1,rejected:2}
    # validates :status, inclusion:{in:%w(pending confirmed rejected)}
    validates :date, presence:true ,  format: {with: /\A\d{4}-(0[1-9]|1[0-2])-(0[1-9]|1\d|2\d|30|31)\z/ , message: "format is YYYY-MM-DD"}
    validates  :time , presence:true, format: { with: /\A([01]\d|2[0-3]):([0-5]\d)\z/, message: 
        "should be in the format hh:mm and 00 <= hh  <= 23 , 00 <= mm <= 59" }
    validate   :date_valid, :date_time_after_current_time

    # fetch only pending booking
    scope :pending , -> {where(status: 'pending')}

    private 
        def date_valid
            # return if format is not correct
            return if errors[:date].size > 0
            dt = date.split("-")
            y , m , d = dt[0].to_i , dt[1].to_i , dt[2].to_i
            errors.add(:date , "not valid") if !Date.valid_date?(y,m,d)

        end
        # TODO
        def date_time_after_current_time
            return if errors[:time].size > 0 || errors[:date].size > 0 
            datetime_string = "#{date} #{time}"
            format = '%Y-%m-%d %H:%M'
            datetime = DateTime.strptime(datetime_string, format)
            # TODO UTC vs local time comparison
            errors.add(:date_time, " in past not allowed") if datetime < Time.now
        end
end



