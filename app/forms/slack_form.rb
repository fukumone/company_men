class SlackForm
  # include Virtus.model
  include ActiveModel::Model

  def initialize(params)
    @params = params
    @text = params["text"]
  end

  def slack_notify(message:)
    notifier = Slack::Notifier.new('https://hooks.slack.com/services/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')
    notifier.ping(message)
  end

  def save
    true
  end
end
