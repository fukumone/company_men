module Triggers
  class RegisterTimeSheetStrategy < ParentStrategy
    include ActiveModel::Model

    attr_reader :params, :user_id, :text, :work_in_or_out

    validates :params,
              :user_id,
              :text,
              :work_in_or_out,
              presence: true

    def initialize(params)
      @params = params
      @text = params['text']
      @user_id = params['user_id']
      super(failure_message)
      assign_attributes
    end

    def execute
      if valid?
        employee = Employee.find_by(slack_user_id: user_id)
        update_time_sheet!(employee)
        message = work_in_or_out == 'ok' ? '勤務開始しました' : '勤務が終了しました'
        send_slack(message: message)
      else
        raise SlackEventError, 'タイムシートを登録できませんでした'
      end
    rescue => e
      self.failure_message = 'タイムシートの登録に失敗しました'
      raise SlackEventError, e
    end

    private

    def update_time_sheet!(employee)
      time_sheet = employee.time_sheets.find_by(work_day: Date.current)
      current = Time.current
      time_sheet.clock_in = current if work_in_or_out == 'ok'
      time_sheet.clock_out = current if work_in_or_out == 'bye'
      time_sheet.save!
    rescue => e
      raise SlackEventError, e
    end

    # トリガー名 time-sheet ok yyyy:mm:dd:hh:nn
    def assign_attributes
      array = self.text.split(" ")
      @work_in_or_out = array[1]
    rescue => e
      raise SlackEventError, e
    end

  end
end
