class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_title, null: false
      t.string :course_description, null: false
      t.integer :course_length, null: false
      t.datetime :course_start_date
      t.datetime :course_end_date
      
      t.timestamps
    end
  end
end
