class RenameTalentItInCourseTalentAssociation < ActiveRecord::Migration[7.0]
  def change
    remove_reference :course_talent_associations, :talent, index: true
    add_reference :course_talent_associations, :user, index: true
  end
end
