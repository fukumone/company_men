class MainController < ApplicationController
  def index
    @employees = Employee.page(params[:page]).per(20)
  end

  def search
    render action: :index
  end

  def help
  end
end
