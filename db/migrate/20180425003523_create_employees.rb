class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :slack_user_id
      t.string :slack_user_name
      t.integer :paid_vacation_days, default: 0
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
