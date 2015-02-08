class JobsController < ApplicationController
  include WatermarkHelper
  
  def create
    par = job_params
    par[:started] = false

    fb_list = get_facebook_info(par[:info])

    p fb_list
    
    if fb_list.count == 1
      # make watermark and go to processed page
      fb_info = fb_list[0]
      @job = Job.create(par)
      @job.make_watermark_worker(fb_info)
      render :create
      return
    else
      @job = Job.create(par)
      render 'static/missing_fb'
      return
    end
    
  end

  def create_missing
    par = job_params
    par[:started] = false

    fb_url = par.delete(:fb_url)
    fb_info = get_facebook_info_from_url(fb_url)
    
    @job = Job.create(par)
    @job.make_watermark_worker(fb_info)
    render :create
    
  end
  
  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def job_params
    p params
    params.require(:job).permit(:email, :info, :file, :fb_url)
  end
end


