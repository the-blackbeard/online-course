class CourseTalentAssociation < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum user_type: [:talent, :author]

  scope :author_type, -> { where(user_type: CourseTalentAssociation.user_types[:author]) }
  scope :talent_type, -> { where(user_type: CourseTalentAssociation.user_types[:talent]) }

  validate :single_author_for_one_course

  def single_author_for_one_course
    if course.author.present?
      errors.add(:course, "alreay has an author")
    end

  end
end
