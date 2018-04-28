class SlackForm
  include ActiveModel::Model

  attr_accessor :params, :text, :employee, :employee_name, :work_in_or_out, :work_time, :user_id

  validates :text,
            :employee_name,
            :work_in_or_out,
            :work_time,
            presence: true

  validate :invalid_employee

  def initialize(params)
    @params = params
    @text = params['text']
    @user_id = params['user_id']
    assign_attributes
    @employee = Employee.find_by(first_name: employee_name)
  end

  # 社員登録:
  #   トリガー名 join-company-men
  # 当日中に打刻登録:
  #   出社:
  #     トリガー名 ok
  #   退社:
  #     トリガー名 bye
  # 後日打刻登録or打刻変更:
  #   出社:
  #     トリガー名 time-sheet ok yyyy:mm:dd:hh:nn
  #   退社:
  #     トリガー名 time-sheet bye yyyy:mm:dd:hh:nn
  # help:
  #   トリガー名 help
  def slack_notify(message:)
    if valid? && save
      notifier = Slack::Notifier.new('https://hooks.slack.com/services/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')
      notifier.ping(message)
    end
  end

  def save
    time_sheet = @employee.time_sheets.where(work_day: Date.current)
    time_sheet.clock_in = work_time if work_in_or_out == '出社'
    time_sheet.clock_out = work_time if work_in_or_out == '退社'
    time_sheet.save
  end

  private
  def invalid_employee
    unless employee
      errors.add(:base, '存在しない社員です')
    end
  end

  # [トリガー名 社員名 出社or退社 時間]
  def assign_attributes
    array = self.text.split(" ")
    @employee_name = array[1]
    @work_in_or_out = array[2]
    @work_time = array[3]
  end
end
