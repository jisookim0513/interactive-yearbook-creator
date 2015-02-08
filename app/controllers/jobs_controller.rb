class JobsController < ApplicationController
  def create
    par = job_params
    par[:started] = false
    @job = Job.create( par )
    @job.make_watermark_worker
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def job_params
    p params
    params.require(:job).permit(:email, :info, :file)
  end
end


