class CreateCourseTalentAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :course_talent_associations do |t|

      t.references :user
      t.references :course
      t.timestamps
    end
  end
end
