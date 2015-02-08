
class WatermarkFilesWorker
  include Sidekiq::Worker
  
  def perform(args)
    job_id, fb_info = args
    
    puts "HELLO HELLO"
    puts job_id

    job = Job.find_by_id(job_id)
    p job
    
    if job.blank? or job.started
      puts 'skipping job'
      return
    else
      job.started = true
      job.save
      job.watermark_it fb_info
    end

    puts Results.job_mail(job_id).deliver
  end
end
