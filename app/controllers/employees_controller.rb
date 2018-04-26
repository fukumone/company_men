class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @time_sheets = @employee.time_sheets.page(params[:page]).per(20)
  end

  def new
    @employee = Employee.new
  end

  def create
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def employee_params
  end
end
