class User < ApplicationRecord
  has_many :course_talent_associations
  has_many :courses, through: :course_talent_associations
  # has_many :taken_courses, class_name: 'Course', through: :course_talent_association
  # has_many :courses

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
