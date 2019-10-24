class User < ApplicationRecord
    has_secure_password
    validates :userid, {presence: true,uniqueness: true}
    validates :password, presence: true
end
