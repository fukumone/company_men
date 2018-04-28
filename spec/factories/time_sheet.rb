FactoryBot.define do
  factory :time_sheet do
    work_day Date.current
    clock_in nil
    clock_out nil
    employee
  end
end
