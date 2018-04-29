class SlackNotify
  include ActiveModel::Model

  attr_reader :strategy

  validates :strategy,
            presence: true

  def initialize(strategy:)
    @strategy = strategy
  end

  def execute
    strategy.execute
  rescue Triggers::SlackEventError => e
    strategy.send_slack(message: strategy.failure_message)
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end
end
