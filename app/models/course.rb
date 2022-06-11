class Course < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :talents, class_name: 'User', through: :course_talent_association

  validates_presence_of :course_title, :course_description, :course_length
  validates :course_length, numericality: { greater_than_or_equal_to: 0 }
  validate :end_date_is_after_start_date

  def end_date_is_after_start_date
    return if course_end_date.blank? || course_start_date.blank?

    if course_end_date < course_start_date
      errors.add(:course_end_date, "cannot be before the course start date")
    end
  end

end
