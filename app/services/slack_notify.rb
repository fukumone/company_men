class SlackNotify
  include ActiveModel::Model

  attr_reader :strategy

  validates :strategy,
            presence: true

  def initialize(strategy:)
    @strategy = strategy
  end

  # 社員登録:
  #   トリガー名 join-company-men
  # 当日中に打刻登録:
  #   出社:
  #     トリガー名 ok
  #   退社:
  #     トリガー名 bye
  # 後日打刻登録or打刻変更:
  #   出社:
  #     トリガー名 time-sheet ok yyyy:mm:dd:hh:nn
  #   退社:
  #     トリガー名 time-sheet bye yyyy:mm:dd:hh:nn
  # help:
  #   トリガー名 help
  def execute
    strategy.execute
  rescue Triggers::TrigerEventError => e
    strategy.send_slack(message: strategy.failure_message)
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end
end
