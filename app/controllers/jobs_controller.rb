class JobsController < ApplicationController
  include WatermarkHelper
  
  def create
    par = job_params
    par[:started] = false

    fb_list = get_facebook_info(par[:info])
    
    if fb_list.count == 1
      # make watermark and go to processed page
      @job = Job.create( par )
      @job.make_watermark_worker
      render :create
      return
    else
      @job = Job.new
      render 'static/missing_fb'
      return
    end
    
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def job_params
    p params
    params.require(:job).permit(:email, :info, :file)
  end
end


