class NotifyController < ApplicationController
  protect_from_forgery :except => [:receive]

  def receive
    slack_notify = SlackNotify.new(strategy: trigger_hanlder)
    slack_notify.execute
  rescue => e
    strategy = Triggers::ParentStrategy.new
    strategy.send_slack(message: e.message)
  end

  private

  def trigger_hanlder
    text = params['text'].split(" ")
    text_parameter = text[1]
    if text_parameter == 'join-company-men'
      Triggers::CreateEmployeeStrategy.new(params)
    elsif text_parameter == 'ok' || text_parameter == 'bye'
      Triggers::RegisterTimeSheetStrategy.new(params)
    elsif text_parameter == 'time-sheet'
      Triggers::UpdateTimeSheetStrategy.new(params)
    elsif text_parameter == 'help'
      Triggers::HelpStrategy.new
    else
      raise Triggers::SlackEventError, "認識できないトリガーです\n 「トリガー名 help」でトリガー調べてください"
    end
  end
end
