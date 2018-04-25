class TimeSheet < ApplicationRecord
  belongs_to :employee

  enum status: { off: 0, working: 1, done: 2 }

  validates :work_day, uniqueness: { scope: :employee_id }

  def working_time
    time = self.clock_out - self.clock_in
    (time / 3600.0).floor(3)
  end

  def self.sheet_format(time: nil)
    time.strftime("%H時 %M分") if time
  end
end
