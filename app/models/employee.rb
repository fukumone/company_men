class Employee < ApplicationRecord
  has_many :time_sheets

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def current_time_sheet
    time_sheet = self.time_sheets.find_or_create_by(work_day: Date.current)
    time_sheet
  end
end
