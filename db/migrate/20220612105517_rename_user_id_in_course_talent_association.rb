class RenameUserIdInCourseTalentAssociation < ActiveRecord::Migration[7.0]
  def change
    remove_reference :course_talent_associations, :user, index: true
    add_reference :course_talent_associations, :talent, foreign_key: { to_table: :users }, index: true
  end
end
