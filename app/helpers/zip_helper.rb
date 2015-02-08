require 'rubygems'
require 'zip'
require 'pathname'
require 'net/http'

module ZipHelper

  # Creates a zip file in the given path
  # Creates the directory if it doesn't exist
  # Needs to be changed to take a aws urls as input and uplaods the zip file to the aws
  def zip(zipfile_path, input_filepaths)
    zipfile_name = File.basename(zipfile_path)
    directory_name = File.dirname(zipfile_path)

    Dir.mkdir(directory_name) unless File.exists?(directory_name)
    Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
      input_filepaths.each do |filepath|
		# Two arguments:
		# - The name of the file as it will appear in the archive
		# - The original file, including the path to find it
		filename = File.basename(filepath)
		zipfile.add(filename, filepath)
      end
    end
    return zipfile_path
  end

  
  #Takes a job entry, extrat it and puts individual file to the aws url
  def process_images_from_job(job)
    aws_url = job.file.expiring_url(10.minutes)
    zip_path = "#{Rails.root}" + Tempfile.new('tmp').path
    pid = system('wget -O %{dir} %{url}'  % {:dir => zip_path ,:url => aws_url})
    tmp_dir = "#{Rails.root}" +  Dir.mktmpdir
    Dir.mkdir(tmp_dir) unless File.exists?(tmp_dir)
    sleep(10) #Waits until the file finishes being made and directory

    Zip::File.open(zip_path) do |zip_file|
      # Handle entries one by one
      zip_file.each do |entry|
        original_file_name = entry.name
        original_content_type = get_content_type(original_file_name)
        original_file_size = entry.size
        
        watermarked_picture = watermark(original_file_name)
        # watermarked_content_type = get_content_type(watermarked_picture)
        # watermarked_file_name = watermarked_picture.name
        # watermarked_file_size = watermarked.size
        
        entry.extract("#{Rails.root}" + tmp_dir + "/" + original_file_name)
        image = Image.create({ :status => 1, 
                               :original_file_name => original_file_name,
                               :original_content_type => original_content_type,
                               :original_file_size => original_file_size,
                               :original_updated_at => Time.now,
                               #:watermarked_file_name => original_file_name,
                               #:watermarked_content_type => original_content_type,
                               #:watermarked_file_size => original_file_size,
                               #:watermarked_updated_at => Time.now,
                               :job_id => job.id
                             })
        metadata = Metadata.create({
                                     #:facebook => "magikarp",
                                     #:linkedin => "magikarp",
                                   })
        
        image.metadata_id = metadata.id
        
      end
    end
    return tmp_dir
  end
  
  def get_content_type(file_name)
    temp = File.extname(file_name)
    return temp[1,temp.length]
  end

  def watermark(x)
    return "M"
  end

  def temp()
    include ZipHelper
    ZipHelper.process_images_from_job(Job.all[0])

  end
end
