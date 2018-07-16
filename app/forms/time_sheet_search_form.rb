class TimeSheetSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :params, :employees, :work_day

  def initialize(params=nil)
    @employees = Employee.active
    @params = params
    if params
      assign_attributes
    else
      @work_day = Time.current
    end
  end

  def list
    data = Struct.new(:employee, :time_sheet)
    array = []
    employees.each do |employee|
      time_sheet = employee.time_sheets.where(work_day: Time.zone.today).last
      array << data.new(employee, time_sheet)
    end
    array
  end

  def search
    data = Struct.new(:employee, :time_sheet)
    array = []
    employees.each do |employee|
      time_sheet = employee.time_sheets.where(work_day: work_day).last
      array << data.new(employee, time_sheet)
    end
    array
  end

  private

  def assign_attributes
    work_day_1i = params['work_day']['work_day(1i)'].to_i
    work_day_2i = params['work_day']['work_day(2i)'].to_i
    work_day_3i = params['work_day']['work_day(3i)'].to_i
    @work_day = Date.new(work_day_1i, work_day_2i, work_day_3i)
  end
end
