require 'rails_helper'

describe SlackForm do
  it 'forms' do
    form = SlackForm.new({'text' => 'company_name name 出社 11:00'})
    work_in_or_out = form.text.split(' ')[2]
  end
end
