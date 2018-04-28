require 'rails_helper'

describe Triggers::CreateEmployeeStrategy do
  it 'success' do
    params = {'user_id' => 'test12345', 'text' => "company_name join-company-men"}
    mock = double("test")
    allow(Slack::Notifier).to receive(:new).and_return(mock)
    allow(mock).to receive(:ping)

    strategy = Triggers::CreateEmployeeStrategy.new(params)
    strategy.execute
    employee = Employee.find_by(slack_user_id: params['user_id'])
    expect(employee.present?).to be_truthy
  end

  it 'failure' do
  end
end
