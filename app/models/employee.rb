class Employee < ApplicationRecord
  has_many :time_sheets

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def current_time_sheet
    time_sheet = self.time_sheets.where(work_day: Date.current).last
    time_sheet
  end
end
