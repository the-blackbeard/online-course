class Course < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :talents, class_name: 'User', through: :course_talent_association

  validates_presence_of :course_title, :course_description, :course_length
  validates :course_length, numericality: { greater_than_or_equal_to: 0 }
  validate :end_date_is_after_start_date

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "cannot be before the start date")
    end
  end

end
