class CreateTimeSheets < ActiveRecord::Migration[5.2]
  def change
    create_table :time_sheets do |t|
      t.date :work_day
      t.datetime :clock_in, precision: 6
      t.datetime :clock_out, precision: 6
      t.integer :status, default: 0, null: false
      t.references :employee, index: true
      t.timestamps
    end
    add_index :time_sheets, [:work_day, :employee_id], :unique => true
  end
end
