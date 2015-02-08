class StaticController < ApplicationController
  def index
    @job = Job.new
  end
  
  def missing_fb
  	@job = Job.new
  end
end
