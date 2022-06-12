class RemoveAuthorColumnFromCourse < ActiveRecord::Migration[7.0]
  def change
    remove_reference :courses, :author, index: true
  end
end
