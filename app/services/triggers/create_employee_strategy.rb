module Triggers
  class CreateEmployeeStrategy < ParentStrategy
    include ActiveModel::Model

    attr_reader :params, :user_id, :text

    validates :user_id,
              :text,
              presence: true

    def initialize(params)
      @params = params
      @text = params['text']
      @user_id = params['user_id']
      super(failure_message)
    end

    def execute
      if valid?
        employee = Employee.find_by(slack_user_id: user_id)
        if employee
          raise SlackEventError, '既に作成済みです'
        end
        ActiveRecord::Base.transaction do
          employee = Employee.create!(slack_user_id: user_id)
          time_sheet = employee.time_sheets.build(work_day: Date.current)
          time_sheet.save!
        end
        send_slack(message: 'ユーザー作成に成功しました！')
      else
        raise SlackEventError, '社員を作成できませんでした'
      end
    rescue => e
      self.failure_message = e.message
      raise SlackEventError, e
    end
  end
end
