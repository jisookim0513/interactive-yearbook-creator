require 'rubygems'
require 'zip'
require 'pathname'

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
  end

  def insert_images_from_zip(zip_name)
  	Zip::File.open(zip_name) do |zip_file|
	  	# Handle entries one by one
	  	zip_file.each do |entry|

	  	end
	end
  end

end
