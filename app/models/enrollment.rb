class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum :role, { student: 0, teacher: 1 }

  validates :course_id, uniqueness: { scope: :user_id }
end
