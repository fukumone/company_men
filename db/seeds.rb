# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

40.times do
  employee_attributes = { first_name: "山田"+rand(10).to_s, last_name: "太郎"+rand(10).to_s }

  employee = Employee.create(employee_attributes)

  time_sheet_attributes = { work_day: Date.current, clock_in: Time.current, clock_out: Time.current.since(8.hour), employee: employee }

  time_sheet = TimeSheet.create(time_sheet_attributes)
end
