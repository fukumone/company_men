class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @time_sheets = @employee.time_sheets.order(work_day: :desc).page(params[:page]).per(20)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash.notice = '社員の作成に成功'
      redirect_to root_path
    else
      flash.now[:alert] = '社員の作成に失敗'
      render 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.assign_attributes(employee_params)
    if @employee.save
      flash.notice = '社員の更新に成功'
      redirect_to root_path
    else
      flash.now[:alert] = '社員の更新に失敗'
      render 'edit'
    end
  end

  def destroy
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name)
  end
end
