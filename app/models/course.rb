class Course < ApplicationRecord
    belongs_to :subject
    
    has_many :topics
    has_many :enrollments
    has_many :users, through: :enrollments
end
