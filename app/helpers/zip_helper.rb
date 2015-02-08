require 'rubygems'
require 'zip'
require 'pathname'
require 'net/http'

module ZipHelper

  # Creates a zip file in the given path
  # Creates the directory if it doesn't exist
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

  def process_images_from_job(zip_file, job_id)
  	Zip::File.open(zip_name) do |zip_file|
	# Handle entries one by one
	zip_file.each do |entry|
		original_file_name = entry.name
		original_content_type = get_content_type(original_file_name)
		original_file_size = entry.size

		watermarked_picture = watermark(original_file_name)
		# watermarked_content_type = get_content_type(watermarked_picture)
		# watermarked_file_name = watermarked_picture.name
		# watermarked_file_size = watermarked.size
		image = Image.create({ :status => 1, 
		  		       :original_file_name => original_file_name,
		  		       :original_content_type => original_content_type,
		  		       :original_file_size => original_file_size,
		  		       :original_updated_at => Time.now,
		  		       :watermarked_file_name => "magikarp.jpg",
		  		       :watermarked_content_type => "jpeg",
		  		       :watermarked_file_size => 200,
		  		       :watermarked_updated_at => Time.now,
		  		       :job_id => job_id
		  		     })
		metadata = Metadata.create({
		  			     :facebook => "magikarp",
		  			     :linkedin => "magikarp",
		  			   })

		image.metadata_id = metadata.id

      end
    end
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
    ZipHelper.process_images_from_job("marion.zip")
  end
end
