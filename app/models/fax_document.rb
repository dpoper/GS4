class FaxDocument < ActiveRecord::Base
	
	after_validation( :on => :create ) {
		raw_file = "#{FAX_FILES_DIRECTORY}/#{self.raw_file}.tif"
		if (! self.raw_file)
			errors.add( :base, "No document found")
		elsif (! File.exists?(raw_file))
			errors.add( :base, "Failed convert document")
		elsif (! self.destination.blank?)
			originate_call(self.destination, raw_file)
		end
	}
	
	after_validation( :on => :update ) {
		raw_file = "#{FAX_FILES_DIRECTORY}/#{self.raw_file}.tif"
		if (! self.raw_file || ! File.exists?(raw_file))
			errors.add( :base, "Fax document not found")
		elsif (! self.destination.blank?)
			originate_call(self.destination, raw_file)
		end
	}
	
	before_destroy {
		raw_file = "#{FAX_FILES_DIRECTORY}/#{self.raw_file}"
		begin
			File.unlink(raw_file + '.tif')
		rescue
		end
		begin
			File.unlink(raw_file + '.png')
		rescue
		end
	}
	
	def save_file(upload)
		if (upload.nil? || ! upload['file'])
			return false
		end
		self.file = upload['file'].original_filename
		resolution = '204x98'
		page_size = '1728x1078'
		input_file = upload['file'].tempfile.path()
		output_file = SecureRandom.hex(10)
		output_path = "#{FAX_FILES_DIRECTORY}/#{output_file}"
		if (File.exist?(output_path+'.tif'))
			return false
		end
		ghostscript_command = "gs -q -r#{resolution} -g#{page_size} -dNOPAUSE -dBATCH -dSAFER -sDEVICE=tiffg3 -sOutputFile=#{output_path}.tif -- #{input_file}"
		system  ghostscript_command
		ghostscript_command = "gs -q -r21x31 -g210x310 -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pngmono -sOutputFile=#{output_path}.png -- #{input_file}"
		system  ghostscript_command
		self.raw_file = output_file
	end
	
	def originate_call(destination, raw_file)
		require 'net/http'
		
		request_path = "/webapi/originate?sofia/internal/#{destination}@#{DOMAIN};fs_path=sip:127.0.0.1:5060%20&txfax(#{raw_file})"
			
		http = Net::HTTP.new(XML_RPC_HOST, XML_RPC_PORT)
		request = Net::HTTP::Get.new(request_path, nil )
		request.basic_auth(XML_RPC_USER , XML_RPC_PASSWORD)
		response = http.request( request )
	end
end