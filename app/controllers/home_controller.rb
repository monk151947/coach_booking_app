class HomeController < ApplicationController
  def index
    @student_id = session[:student_id]
  end

  def dashboard
  end
end
