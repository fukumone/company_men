module Triggers
  class ParentStrategy

    attr_accessor :failure_message

    def execute
      raise SlackEventError, '存在しないトリガーです'
    end

    def send_slack(message:)
      notifier = Slack::Notifier.new('https://hooks.slack.com/services/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')
      notifier.ping(message)
    end
  end
end
