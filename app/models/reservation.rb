require 'date'
class Reservation < ApplicationRecord
    belongs_to :regular_user
    belongs_to :admin, optional:true
    # admin_id will be added only on update
    enum status:{pending:0,confirmed:1,rejected:2}
    # validates :status, inclusion:{in:%w(pending confirmed rejected)}
    validates :date, presence:true
    validates  :time , presence:true
    validate :date_time_after_current_time

    # fetch only pending booking
    scope :pending , -> {where(status: 'pending')}

    private 
        def date_time_after_current_time
            combined_datetime  = "#{date} #{time}"
            # understand this line and varify it properly :TODO
            parsed_datetime = Time.zone.parse(combined_datetime)
            # understand why it can be nil :TODO
            if parsed_datetime.nil? || parsed_datetime <= Time.current
                errors.add(:date_time , "must be after the current time")
            end
          rescue ArgumentError
            errors.add(:date_time, "Invalid datetime format")
        end
end

# booking -> admin_id, user_id , date, time_slot, status, timestamp

