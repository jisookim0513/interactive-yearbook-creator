class WatermarkFilesWorker
  include Sidekiq::Worker

  def perform(job_id)
    puts "HELLO HELLO"
    puts job_id

    
  end
end
