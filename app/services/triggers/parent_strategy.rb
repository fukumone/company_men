module Triggers
  class ParentStrategy

    attr_accessor :failure_message

    def execute
      raise SlackEventError, '存在しないトリガーです'
    end

    def send_slack(message:)
      notifier = Slack::Notifier.new(ENV['SLACK_HOOK_URL'])
      notifier.ping(message)
    rescue => e
      raise StandardError, 'slackの連携に失敗しました'
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
    end
  end
end
