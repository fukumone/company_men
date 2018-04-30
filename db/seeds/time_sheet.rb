def set_off_time_sheet(employee, date)
  {
    employee: employee,
    work_day: date,
    clock_in: nil,
    clock_out: nil,
  }
end

def set_working_time_sheet(employee, date)
  am_ten = 10
  clock_in = Time.new(date.year, date.month, date.day, am_ten)
  {
    employee: employee,
    work_day: date,
    clock_in: clock_in,
    clock_out: nil,
  }
end

def set_done_time_sheet(employee, date)
  am_ten = 10
  pm_seven = 19
  clock_in = Time.new(date.year, date.month, date.day, am_ten)
  clock_out = Time.new(date.year, date.month, date.day, pm_seven)
  {
    employee: employee,
    work_day: date,
    clock_in: clock_in,
    clock_out: clock_out,
  }
end

def create_one_month_time_sheets
  one_month_ago = 1.month.ago
  beginning_of_day = 1
  date_array = (Date.new(one_month_ago.year, one_month_ago.month, beginning_of_day) .. one_month_ago.end_of_day).select{|date| date.day}
  Employee.all.each do |employee|
    date_array.each do |date|
      TimeSheet.create(set_off_time_sheet(employee, date)) if holiday?(date)
      TimeSheet.create(set_done_time_sheet(employee, date)) unless holiday?(date)
    end
  end
end

def create_current_month_time_sheets
  current = Time.current
  date_current = Date.current
  beginning_of_day = 1
  date_array = (Date.new(current.year, current.month, beginning_of_day) .. current.end_of_day).select{|date| date.day}
  Employee.all.each do |employee|
    date_array.each do |date|
      now_day = date == date_current
      if holiday?(date)
        TimeSheet.create(set_off_time_sheet(employee, date))
      elsif now_day
        TimeSheet.create(set_working_time_sheet(employee, date))
      elsif !holiday?(date) && !now_day
        TimeSheet.create(set_done_time_sheet(employee, date))
      end
    end
  end
end

def holiday?(date)
  sunday_flag = 0
  saturday_flag = 6
  date.wday == saturday_flag || date.wday == sunday_flag
end

create_one_month_time_sheets
create_current_month_time_sheets
