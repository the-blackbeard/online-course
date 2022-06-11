class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.timestamps

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number
    end
  end
end
