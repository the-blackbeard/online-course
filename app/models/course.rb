class Course < ApplicationRecord
  has_many :course_talent_associations
  has_many :users, through: :course_talent_associations

  has_one :author_type_users, -> { author_type }, class_name: "CourseTalentAssociation"
  has_many :talent_type_users, -> { talent_type }, class_name: "CourseTalentAssociation"

  has_many :talents, through: :talent_type_users, source: :user
  has_one :author, through: :author_type_users, source: :user

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
