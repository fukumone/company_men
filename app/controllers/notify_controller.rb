class NotifyController < ApplicationController
  protect_from_forgery :except => [:receive]

  def receive
    form = SlackForm.new(params)
    if form.valid && form.save
      form.slack_notify(message: '打刻完了、今日もよろしくお願いします')
    end
  end
end
