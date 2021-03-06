xml.instruct!  # <?xml version="1.0" encoding="UTF-8"?>

xml.SnomIPPhoneDirectory {
	xml.Title(t(:calls_missed_number, :calls => @call_logs_missed.count))
	@call_logs_missed.each { |call_entry|
		if (call_entry.created_at < Time.now.advance(:hours => -12))
			date_formatted = l(call_entry.created_at.localtime, :format => :call_log_old)
		else
			date_formatted = l(call_entry.created_at.localtime, :format => :call_log_recent)
		end
		source_name   = call_entry.source_name
		source_number = call_entry.source
		if (source_number.blank? && source_name.blank?)
			source_name = 'anonymous'
		end
		xml.tag!( 'DirectoryEntry' ) {
			xml.Name(t(:xml_menu_call_log_entry, :call_date => date_formatted, :name => source_name, :number => source_number))
			xml.Telephone( call_entry.source )
		}
	}
}


# Local Variables:
# mode: ruby
# End:

