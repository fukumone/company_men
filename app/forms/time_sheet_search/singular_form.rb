module TimeSheetSearch
  class SingularForm
    attr_reader :params, :employee, :work_day

    def initialize(params)
      @params = params
      @employee = Employee.find(params[:id])
      if params[:work_day]
        assign_attributes
      else
        @work_day = Time.current
      end
    end

    def list
      beginning_of_month = Time.current.beginning_of_month
      end_of_month = Time.current.end_of_month
      employee.time_sheets.where(work_day: beginning_of_month..end_of_month)
    end

    def search
      employee.time_sheets.where(work_day: work_day.beginning_of_month..work_day.end_of_month)
    end

    private

    def assign_attributes
      work_day_1i = params['work_day']['work_day(1i)'].to_i
      work_day_2i = params['work_day']['work_day(2i)'].to_i
      @work_day = Date.new(work_day_1i, work_day_2i)
    end
  end
end
