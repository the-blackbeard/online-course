class CourseTalentAssociation < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum user_type: [:talent, :author]

  scope :author_type, -> { where(user_type: CourseTalentAssociation.user_types[:author]) }
  scope :talent_type, -> { where(user_type: CourseTalentAssociation.user_types[:talent]) }
end
