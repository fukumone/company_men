class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @time_sheets = @employee.time_sheets.page(params[:page]).per(20)
  end
end
