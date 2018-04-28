require 'rails_helper'

describe Triggers::RegisterTimeSheetStrategy do
  before do
    mock = double("test")
    allow(Slack::Notifier).to receive(:new).and_return(mock)
    allow(mock).to receive(:ping)
  end

  let(:employee) { create(:employee) }

  it 'Success update clock_in column' do
    employee = create(:employee)
    time_sheet = create(:time_sheet, employee: employee)
    params = {'user_id' => "#{employee.slack_user_id}", 'text' => "trigger ok"}
    strategy = Triggers::RegisterTimeSheetStrategy.new(params)
    strategy.execute
    time_sheet.reload
    expect(time_sheet.clock_in).to_not be_nil
    expect(time_sheet.clock_out).to be_nil
  end

  it 'Success update clock_out column' do
    employee = create(:employee)
    time_sheet = create(:time_sheet, employee: employee)
    params = {'user_id' => "#{employee.slack_user_id}", 'text' => "trigger bye"}
    strategy = Triggers::RegisterTimeSheetStrategy.new(params)
    strategy.execute
    time_sheet.reload
    expect(time_sheet.clock_in).to be_nil
    expect(time_sheet.clock_out).to_not be_nil
  end

  it 'Failure create time_sheet' do
    params = {}
    expect{
      strategy = Triggers::RegisterTimeSheetStrategy.new(params)
      strategy.execute
    }.to raise_error(Triggers::SlackEventError)
  end
end
