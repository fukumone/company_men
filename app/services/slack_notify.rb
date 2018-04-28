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
  # 後日打刻変更:
  #   出社:
  #     トリガー名 time-sheet ok yyyy-dd-mm(更新したい日にち) hh:nn(更新する時間)
  #   退社:
  #     トリガー名 time-sheet bye yyyy-dd-mm(更新したい日にち) hh:nn(更新する時間)
  # help:
  #   トリガー名 help
  def execute
    strategy.execute
  rescue Triggers::SlackEventError => e
    strategy.send_slack(message: strategy.failure_message)
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end
end
