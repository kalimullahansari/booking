class RegularUser < User
    has_many :reservations
    enum status: {unblock:0,block:1}
end
