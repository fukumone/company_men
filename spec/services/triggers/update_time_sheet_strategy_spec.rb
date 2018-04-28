require 'rails_helper'

describe Triggers::UpdateTimeSheetStrategy do
  before do
    mock = double("test")
    allow(Slack::Notifier).to receive(:new).and_return(mock)
    allow(mock).to receive(:ping)
  end

  let(:employee) { create(:employee) }

  it 'Success update clock_in column' do
    clock_in = Time.new(2018, 5, 1, 7).in_time_zone
    work_day = Date.new(2018, 5, 1).in_time_zone
    time_sheet = create(:time_sheet, work_day: work_day, clock_in: clock_in)
    params = {
               'user_id' => "#{time_sheet.employee.slack_user_id}",
               'text' => "trigger time-sheet ok 2018-05-01 09:00:00"
             }
    strategy = Triggers::UpdateTimeSheetStrategy.new(params)
    strategy.execute
    expect(time_sheet.clock_in).to eq(clock_in)
    time_sheet.reload
    ans = Time.new(2018, 5, 1, 9).in_time_zone
    expect(time_sheet.clock_in).to eq(ans)
  end

  it 'Success update clock_out column' do
    clock_in = Time.new(2018, 5, 1, 7).in_time_zone
    clock_out = Time.new(2018, 5, 1, 18).in_time_zone
    work_day = Date.new(2018, 5, 1)
    time_sheet = create(:time_sheet, work_day: work_day, clock_in: clock_in, clock_out: clock_out)
    params = {
               'user_id' => "#{time_sheet.employee.slack_user_id}",
               'text' => "trigger time-sheet bye 2018-05-01 21:00:00"
             }
    strategy = Triggers::UpdateTimeSheetStrategy.new(params)
    strategy.execute
    expect(time_sheet.clock_out).to eq(clock_out)
    time_sheet.reload
    ans = Time.new(2018, 5, 1, 21).in_time_zone
    expect(time_sheet.clock_out).to eq(ans)
  end

  it 'Failure create time_sheet' do
    params = {}
    expect{
      strategy = Triggers::UpdateTimeSheetStrategy.new(params)
      strategy.execute
    }.to raise_error(Triggers::SlackEventError)
  end
end
