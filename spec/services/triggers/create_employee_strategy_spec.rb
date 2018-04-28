require 'rails_helper'

describe Triggers::CreateEmployeeStrategy do
  before do
    mock = double("test")
    allow(Slack::Notifier).to receive(:new).and_return(mock)
    allow(mock).to receive(:ping)
  end

  it 'Success create employee' do
    params = {'user_id' => 'test12345', 'text' => "company_name join-company-men"}

    strategy = Triggers::CreateEmployeeStrategy.new(params)
    strategy.execute
    employee = Employee.find_by(slack_user_id: params['user_id'])
    expect(employee.present?).to be_truthy
  end

  it 'Failure create employee' do
    params = {}
    strategy = Triggers::CreateEmployeeStrategy.new(params)
    expect{ strategy.execute }.to raise_error(Triggers::SlackEventError)
  end
end
