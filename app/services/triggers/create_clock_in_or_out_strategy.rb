module Triggers
  class CreateClockInOrOutStrategy < ParentStrategy
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
        create_time_sheet!(employee)
        send_slack(message: 'タイムシートを登録しました！')
      else
        raise TrigerEventError, 'タイムシートを登録できませんでした'
      end
    rescue => e
      self.failure_message = 'タイムシートの登録に失敗しました'
      raise TrigerEventError, e
    end

    private

    def create_time_sheet!(employee)
      time_sheet = employee.time_sheets.build(work_day: Date.current)
      current = Time.current
      time_sheet.clock_in = current if work_in_or_out == 'ok'
      time_sheet.clock_out = current if work_in_or_out == 'bye'
      time_sheet.save!
    rescue => e
      raise TrigerEventError, e
    end

    # トリガー名 time-sheet ok yyyy:mm:dd:hh:nn
    def assign_attributes
      array = self.text.split(" ")
      @work_in_or_out = array[1]
    end

  end
end
