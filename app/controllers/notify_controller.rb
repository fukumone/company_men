class NotifyController < ApplicationController
  protect_from_forgery :except => [:receive]

  def receive
    form = SlackForm.new(params)
    form.slack_notify
  end
end
