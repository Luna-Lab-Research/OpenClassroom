class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :system_role, { regular: 0, admin: 1 }

  def admin?
    system_role == "admin"
  end

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course

  has_many :teaching_enrollments,
           -> { where(role: "teacher") },
           class_name: "Enrollment"
  has_many :teaching_courses,
           through: :teaching_enrollments,
           source: :course

  has_many :student_enrollments,
           -> { where(role: "student") },
           class_name: "Enrollment"
  has_many :learning_classes,
           through: :student_enrollments,
           source: :course

  has_many :created_courses,
           class_name: "Course",
           foreign_key: "creator_id"

  def teacher_of?(course)
    teaching_courses.include?(course)
  end

  def student_in?(course)
    learning_classes.include?(course)
  end

  def can_create_class?
    can_create_classes || admin?
  end

  def role_in_course(course)
    enrollment = enrollments.find_by(course: course)
    enrollment&.role
  end
end
