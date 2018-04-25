class SlackForm
  # include Virtus.model
  include ActiveModel::Model

  attr_reader :params, :text

  def initialize(params)
    @params = params
    @text = params['text']
  end

  def slack_notify(message:)
    notifier = Slack::Notifier.new('https://hooks.slack.com/services/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')
    notifier.ping(message)
  end

  def save
    true
  end

  def format_text
    p self.text
  end

  private

end
