class Car < ActiveRecord::Base
    belongs_to :user
    validates :make, :model, :year, presence: :true
end