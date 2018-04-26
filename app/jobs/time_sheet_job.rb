class TimeSheetJob < ApplicationJob
  queue_as :default

  def perform(*args)
    current = Date.current
    Employee.all.each do |employee|
      begin
        time_sheet = employee.time_sheets.build
        time_sheet.work_day = current
        time_sheet.save!
      rescue => e
        logger.error(e.message)
      end
    end
  end
end
