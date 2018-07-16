module TimeSheetSearch
  class SingularForm
    attr_reader :params, :employee, :work_day

    def initialize(params)
      @params = params
      @employee = Employee.find(params[:id])
    end

    def list
      employee.time_sheets
    end

    def search
    end
  end
end
