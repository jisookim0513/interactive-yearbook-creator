class JobsController < ApplicationController
  def create
    @job = Job.create( job_params )
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def job_params
    params.require(:job)
  end
end
