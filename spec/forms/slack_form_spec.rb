require 'rails_helper'

describe SlackForm do
  it 'forms' do
    form = SlackForm.new({'text' => 'company_name employee_name 出社 11:00'})
    p form.valid?
    p form.slack_notify(message: "aaa")
  end
end
