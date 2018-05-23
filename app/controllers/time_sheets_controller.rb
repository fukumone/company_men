class TimeSheetsController < ApplicationController
  def edit
    @time_sheet = TimeSheet.find(params[:id])
    @employee = @time_sheet.employee
  end

  def update
    @time_sheet = TimeSheet.find(params[:id])
    @time_sheet.assign_attributes(time_sheet_params)
    if @time_sheet.save
      flash.notice = 'タイムシートの更新に成功'
      redirect_to root_path
    else
      flash.now[:alert] = 'タイムシートの更新に失敗'
      render 'edit'
    end
  end

  private

  def time_sheet_params
    params.require(:time_sheet).permit(:work_day, :clock_in, :clock_out)
  end
end
