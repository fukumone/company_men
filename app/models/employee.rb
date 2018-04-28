class Employee < ApplicationRecord
  scope :active, -> { where(deleted_at: nil) }

  has_many :time_sheets

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def current_time_sheet
    time_sheet = self.time_sheets.find_by(work_day: Date.current)
    time_sheet
  end

  def total_working_time(date:)
    records = self.time_sheets.where(work_day: date.beginning_of_month..date.end_of_month)
    sum = 0
    records.each do |time_sheet|
      sum += time_sheet.working_time
    end
    sum
  end
end
