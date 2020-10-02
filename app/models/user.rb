class User < ActiveRecord::Base
    has_many :cars
    has_secure_password
    validates :username, uniqueness: :true
end