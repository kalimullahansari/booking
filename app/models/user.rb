class User < ApplicationRecord
    has_secure_password
    validates :email, presence:true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :type, presence:true, inclusion: {in: %w(RegularUser Admin)}
    before_validation :downcase_email

    def admin?
        type == 'Admin'
    end

    def regular_user?
        type == "RegularUser"
    end

    private 
        # same email in uppercase has to be treated same.
        def downcase_email
            email.downcase! if email
        end
end
