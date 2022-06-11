class CourseTalentAssociation < ApplicationRecord
  belongs_to :talent, class_name: 'User'
  belongs_to :course
end
