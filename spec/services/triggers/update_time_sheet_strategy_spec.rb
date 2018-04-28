require 'rails_helper'

describe Triggers::UpdateTimeSheetStrategy do
  before do
    mock = double("test")
    allow(Slack::Notifier).to receive(:new).and_return(mock)
    allow(mock).to receive(:ping)
  end

  let(:employee) { create(:employee) }

  # トリガー名 time-sheet ok yyyy:mm:dd:hh:nn

  it 'Success update time_sheet' do
    employee = create(:employee)
    time_sheet = create(:time_sheet, employee: employee)
    params = {'user_id' => "#{employee.slack_user_id}", 'text' => "trigger time-sheet ok 2018:05:01:09:00"}
    strategy = Triggers::UpdateTimeSheetStrategy.new(params)
    strategy.execute
    time_sheet.reload
    expect(time_sheet.clock_in).to_not be_nil
    expect(time_sheet.clock_out).to be_nil
  end

  it 'Success update time_sheet' do
    employee = create(:employee)
    time_sheet = create(:time_sheet, employee: employee)
    params = {'user_id' => "#{employee.slack_user_id}", 'text' => "trigger bye"}
    strategy = Triggers::UpdateTimeSheetStrategy.new(params)
    strategy.execute
    time_sheet.reload
    expect(time_sheet.clock_in).to be_nil
    expect(time_sheet.clock_out).to_not be_nil
  end

  it 'Failure create time_sheet' do
    params = {}
    strategy = Triggers::UpdateTimeSheetStrategy.new(params)
    expect{ strategy.execute }.to raise_error(Triggers::SlackEventError)
  end
end
