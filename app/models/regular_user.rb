class RegularUser < User
    has_many :reservations
    enum status: {unblock:0,block:1}
    validates :status, inclusion: {in: %w(block unblock)}
end
