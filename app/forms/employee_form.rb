class EmployeeForm
  include ActiveModel::Model

  attr_reader :params, :first_name, :last_name, :paid_vacation_days, :employee

  def initialize(:params, employee)
    @params = params
    @employee = employee if employee
  end

  def update
    employee.update(params)
  end
end
