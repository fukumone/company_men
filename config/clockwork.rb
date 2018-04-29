require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)
require 'clockwork'

module Clockwork
  logger = ActiveSupport::Logger.new(Rails.root.join('log', "clockwork.log"))
  configure do |config|
    config[:logger] = logger
  end

  handler do |job|
    job&.perform_now
  end

  every(1.day, TimeSheetJob, :at => '00:00')
  every(1.day, NotifyClockOutJob, :at => '07:00')
end
