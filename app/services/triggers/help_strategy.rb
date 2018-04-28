module Triggers
  class HelpStrategy < ParentStrategy
    require 'active_support/core_ext/string/strip'

    def execute
      send_slack(message: message)
    rescue => e
      self.failure_message = 'helpの取得に失敗'
      raise SlackEventError, e
    end

    def message
      <<-"EOS".strip_heredoc
        ```
        社員登録:
          トリガー名 join-company-men
        当日中に打刻登録:
          出社:
            トリガー名 ok
          退社:
            トリガー名 bye
        後日打刻変更:
          出社:
            トリガー名 time-sheet ok yyyy-dd-mm(更新したい日にち) hh:nn(更新する時間)
          退社:
            トリガー名 time-sheet bye yyyy-dd-mm(更新したい日にち) hh:nn(更新する時間)
        help:
          トリガー名 help
        ```
      EOS
    end
  end
end
