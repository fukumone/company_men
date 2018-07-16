class MainController < ApplicationController
  def index
    @form = TimeSheetSearchForm.new
    @employees = @form.employees.page(params[:page]).per(20)
    @list = @form.list
  end

  def search
    @form = TimeSheetSearchForm.new(params)
    @employees = @form.employees.page(params[:page]).per(20)
    @list = @form.search
    render action: :index
  end

  def help
  end
end
