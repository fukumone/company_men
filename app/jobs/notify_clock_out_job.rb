# 退勤の登録していないユーザーに登録を促す
class NotifyClockOutJob < ApplicationJob
  queue_as :default

  def perform(*args)
    time_sheets = TimeSheet.where.not(clock_in: nil).where(clock_out: nil)
    time_sheets.each do |time_sheet|
      begin
        employee = time_sheet.employee
        slack_user_name = employee.slack_user_name
        notifier = Slack::Notifier.new(ENV['SLACK_HOOK_URL'])
        notifier.ping("#{slack_user_name}さん、#{time_sheet.work_day.strftime('%Y年%m月%d日')}の退勤を登録してください")
      rescue => e
        logger.error(e.message)
      end
    end
  end
end
