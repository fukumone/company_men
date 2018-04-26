class TimeSheet < ApplicationRecord
  belongs_to :employee

  enum status: { off: 0, working: 1, done: 2 }

  validates :work_day, uniqueness: { scope: :employee_id }

  before_save :update_status

  def ja_work_day
    date = self.work_day
    "#{date.strftime('%m月%d日')} (#{%w(日 月 火 水 木 金 土)[date.wday]})"
  end

  def working_time
    return 0 if self.clock_out.nil? || self.clock_in.nil?
    time = self.clock_out - self.clock_in
    (time / 3600.0).floor(3)
  end

  def self.sheet_format(time: nil)
    time.strftime("%H時 %M分") if time
  end

  private

  def update_status
    if self.clock_in && self.clock_out
      self.status = :done
    end

    if self.clock_in && self.clock_out.nil?
      self.status = :working
    end

    if self.clock_in.nil? && self.clock_out.nil?
      self.status = :off
    end
  end
end
