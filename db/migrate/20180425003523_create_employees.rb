class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :slack_user_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
