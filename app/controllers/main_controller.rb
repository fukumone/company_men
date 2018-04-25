class MainController < ApplicationController
  def index
    @employees = Employee.page(params[:page]).per(20)
  end

  def search
  end
end
