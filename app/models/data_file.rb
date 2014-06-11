class DataFile < ActiveRecord::Base
	#sobreescribimos el save para guardar el file
	def self.save(upload)
	    name =  upload.original_filename
	    directory = "public/data"
	    # create the file path
	    path = File.join(directory, name)
	    # write the file
	    File.open(path, "wb") { |f| f.write(upload.read) }
	    return path
	end
end
