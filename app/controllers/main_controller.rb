class MainController < ApplicationController
  def index
    @form = TimeSheetSearchForm.new(TimeSheetSearch::MultipleForm.new).strategy
    @employees = @form.employees.page(params[:page]).per(20)
    @list = @form.list
  end

  def search
    @form = TimeSheetSearchForm.new(TimeSheetSearch::MultipleForm.new(params)).strategy
    @employees = @form.employees.page(params[:page]).per(20)
    @list = @form.search
    render action: :index
  end

  def help
  end
end
