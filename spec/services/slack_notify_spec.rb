require 'rails_helper'

describe SlackNotify do
  it 'Success trigger event' do
    params = {'user_name' => 'hoge', 'user_id' => 'test12345', 'text' => "trigger join-company-men"}
    mock = double("test")
    allow(Slack::Notifier).to receive(:new).and_return(mock)
    allow(mock).to receive(:ping)

    slack_notify = SlackNotify.new(strategy: Triggers::CreateEmployeeStrategy.new(params))
    slack_notify.execute
    employee = Employee.find_by(slack_user_id: params['user_id'])
    expect(employee.present?).to be_truthy
  end
end
