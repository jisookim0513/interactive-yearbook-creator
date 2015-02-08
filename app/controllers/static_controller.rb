class StaticController < ApplicationController
  def index
    @job = Job.new
  end
  
end
