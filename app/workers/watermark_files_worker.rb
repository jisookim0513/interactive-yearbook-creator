
class WatermarkFilesWorker
  include Sidekiq::Worker
  
  def perform(job_id)
    puts "HELLO HELLO"
    puts job_id

    job = Job.find(job_id)
    p job
    
    if job.blank? or job.started
      return
    else
      job.started = true
      job.watermark_it
    end

    Results.job_mail(job_id).deliver
  end
end
