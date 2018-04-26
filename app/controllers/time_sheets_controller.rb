class TimeSheetsController < ApplicationController
  def edit
    @time_sheet = TimeSheet.find(params[:id])
    @employee = @time_sheet.employee
  end
end
