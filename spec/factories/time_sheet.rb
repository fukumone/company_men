FactoryBot.define do
  factory :time_sheet do
    work_day Date.current
    clock_in Time.current
    clock_out Time.current.since(8.hour)
    employee
  end
end
