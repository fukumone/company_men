class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @form = TimeSheetSearchForm.new(TimeSheetSearch::SingularForm.new(params)).strategy
    @employee = @form.employee
    @time_sheets = @form.list.order(work_day: :desc).page(params[:page]).per(20)
  end

  def search
    @form = TimeSheetSearchForm.new(TimeSheetSearch::SingularForm.new(params)).strategy
    @employee = @form.employee
    @time_sheets = @form.search.order(work_day: :desc).page(params[:page]).per(20)
    render action: :show
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.assign_attributes(employee_params)
    if @employee.save
      flash.notice = '社員の更新に成功'
      redirect_to action: :index
    else
      flash.now[:alert] = '社員の更新に失敗'
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.destroy
      flash.notice = '社員の削除に成功'
      redirect_to action: :index
    else
      flash.now[:alert] = '社員の削除に失敗'
      render 'index'
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :paid_vacation_days)
  end
end
