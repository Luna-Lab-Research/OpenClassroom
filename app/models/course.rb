class Course < ApplicationRecord
    belongs_to :creator, class_name: "User"
    belongs_to :subject, optional: true

    has_many :enrollments, dependent: :destroy
    has_many :users, through: :enrollments

    validates :name, presence: true
    validates :end_date_after_start_date, if: -> { start_date.present? && end_date.present? }

    private

    def end_date_after_start_date
        if end_date < start_date
            errors.add(:end_date, "must be after the start date")
        end
    end
end
