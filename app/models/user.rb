class User < ApplicationRecord
  has_many :course_talent_associations
  has_many :courses, through: :course_talent_associations

  has_many :author_type_users, -> { author_type }, class_name: "CourseTalentAssociation"
  has_many :talent_type_users, -> { talent_type }, class_name: "CourseTalentAssociation"

  has_many :courses_taken, through: :talent_type_users, source: :course
  has_many :courses_created, through: :author_type_users, source: :course

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
