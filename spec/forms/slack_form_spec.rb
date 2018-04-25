require 'rails_helper'

describe SlackForm do
  it 'forms' do
    employee = create(:employee)
    form = SlackForm.new({'text' => "company_name #{employee.first_name} 出社 11:00"})
    p employee
    p form.valid?
    p form.slack_notify(message: "aaa")
  end
end
