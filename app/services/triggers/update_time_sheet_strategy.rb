module Triggers
  class UpdateTimeSheetStrategy < ParentStrategy
    include ActiveModel::Model

    attr_reader :params, :user_id, :text, :work_in_or_out, :work_day, :work_time

    validates :params,
              :user_id,
              :text,
              :work_in_or_out,
              :work_day,
              :work_time,
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
        send_slack(message: 'タイムシートを更新にしました！')
      else
        raise SlackEventError, "タイムシートの更新に失敗しました"
      end
    rescue => e
      self.failure_message = 'タイムシートを更新に失敗しました'
      raise SlackEventError, e
    end

    private

    def update_time_sheet!(employee)
      time_sheet = employee.time_sheets.find_by!(work_day: work_day)
      time_sheet.clock_in = time_parse if work_in_or_out == 'ok'
      time_sheet.clock_out = time_parse if work_in_or_out == 'bye'
      time_sheet.save!
    end

    def time_parse
      time = work_day.split("-")
      time_2 = work_time.split(":")
      Time.new(time[0], time[1], time[2], time_2[0], time_2[1])
    end

    def assign_attributes
      array = self.text.split(" ")
      @work_in_or_out = array[2]
      @work_day = array[3]
      @work_time = array[4]
    rescue => e
      raise SlackEventError, e
    end
  end
end
