class Classroom < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true
    
    before_destroy { users.clear }
    has_and_belongs_to_many :users
end
