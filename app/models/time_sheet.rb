class TimeSheet < ApplicationRecord
  belongs_to :employee

  def working_time
    time = self.clock_out - self.clock_in
    (time / 3600.0).floor(3)
  end

  def self.sheet_format(time: nil)
    time.strftime("%H時 %M分") if time
  end
end
