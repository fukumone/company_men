module Triggers
  class CreateEmployeeStrategy < ParentStrategy
    include ActiveModel::Model

    attr_reader :params, :user_id, :text

    validates :user_id,
              :text,
              presence: true

    def initialize(params)
      @params = params
      @text = params['text']
      @user_id = params['user_id']
      super(failure_message)
    end

    def execute
      if valid?
        employee = Employee.find_or_create_by!(slack_user_id: user_id)
        send_slack(message: 'ユーザー作成に成功しました！')
      else
        raise TrigerEventError, '社員を作成できませんでした'
      end
    rescue => e
      self.failure_message = 'ユーザー作成に失敗しました'
      raise TrigerEventError, e
    end
  end
end
