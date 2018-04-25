class CreateTimeSheets < ActiveRecord::Migration[5.2]
  def change
    create_table :time_sheets do |t|
      t.date :work_day
      t.datetime :clock_in, precision: 6
      t.datetime :clock_out, precision: 6
      t.references :employee, index: true
      t.timestamps
    end
  end
end
