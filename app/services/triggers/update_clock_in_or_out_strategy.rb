module Triggers
  class UpdateClockInOrOutStrategy < ParentStrategy
    include ActiveModel::Model

    attr_reader :params, :user_id, :text, :work_in_or_out, :work_time

    validates :params,
              :user_id,
              :text,
              :work_in_or_out,
              :work_time
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
        create_or_update_time_sheet!(employee)
        send_slack(message: 'タイムシートを登録 or 更新にしました！')
      else
        raise TrigerEventError, "タイムシートの登録 or 更新に失敗しました"
      end
    rescue => e
      self.failure_message = 'タイムシートを登録 or 更新に失敗しました'
      raise TrigerEventError, e
    end

    private
    def create_or_update_time_sheet!(employee)
      time_sheet = employee.time_sheets.find_or_initialize_by!(work_day: date_parse(time: work_time))
      time_sheet.clock_in = time_parse(time: work_time) if work_in_or_out == 'ok'
      time_sheet.clock_out = time_parse(time: work_time) if work_in_or_out == 'bye'
      time_sheet.save!
    rescue => e
      raise TrigerEventError, e
    end

    # yyyy:mm:dd:hh:nn => yyyy-mm-dd
    def date_parse(time:)
      split_time = time.split(":")
      year = split_time[0]
      month = split_time[1]
      day = split_time[2]
      "#{year}-#{month}-#{day}"
    end

    # yyyy:mm:dd:hh:nn => yyyy-mm-dd hh:nn
    def time_parse(time:)
      split_time = time.split(":")
      year = split_time[0]
      month = split_time[1]
      day = split_time[2]
      hour = split_time[3]
      min = split_time[4]
      Time.new(year, month, day, hour, min)
    end

    # トリガー名 time-sheet ok yyyy:mm:dd:hh:nn
    def assign_attributes
      array = self.text.split(" ")
      @work_in_or_out = array[2]
      @work_time = array[3]
    end
  end
end
