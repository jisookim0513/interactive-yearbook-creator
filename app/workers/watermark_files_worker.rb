
class WatermarkFilesWorker
  include Sidekiq::Worker
  
  def perform(job_id)
    puts "HELLO HELLO"
    puts job_id

    job = Job.find(job_id)
    p job
    # if job.blank?
    #   return
    # else
    job.watermark_it
    # end

    
  end
end
