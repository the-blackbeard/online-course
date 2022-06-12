class AddColumnInCourseTalentAssociation < ActiveRecord::Migration[7.0]
  def change
    add_column :course_talent_associations, :user_type, :integer
  end
end
