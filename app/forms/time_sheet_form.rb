class TimeSheetForm
  attr_reader :time_sheet, :params, :work_day, :clock_in, :clock_out

  def initialize(time_sheet:, params:)
    @time_sheet = time_sheet
    @params = params
    assign_attributes
  end

  def save
    time_sheet.update(
      work_day: work_day,
      clock_in: clock_in,
      clock_out: clock_out,
    )
  end

  private

  def assign_attributes
    work_day_1i = params['work_day(1i)'].to_i
    work_day_2i = params['work_day(2i)'].to_i
    work_day_3i = params['work_day(3i)'].to_i
    clock_in_1i = params['clock_in(1i)'].to_i
    clock_in_2i = params['clock_in(2i)'].to_i
    clock_in_3i = params['clock_in(3i)'].to_i
    clock_out_1i = params['clock_out(1i)'].to_i
    clock_out_2i = params['clock_out(2i)'].to_i
    clock_out_3i = params['clock_out(3i)'].to_i

    @work_day = Date.new(work_day_1i, work_day_2i, work_day_3i)
    @clock_in = Time.new(clock_in_1i, clock_in_2i, clock_in_3i)
    @clock_out = Time.new(clock_out_1i, clock_out_2i, clock_out_3i)
  end
end
