# ruby encoding: utf-8

# This file should contain all the record creation needed to seed
# the database with its default values. The data can then be loaded
# with the rake db:seed (or created alongside the db with db:setup).

################################################################
# Global configuration
################################################################

Configuration.create([
	{ :name => 'auth_db_engine'              , :value => 'odbc' },
	{ :name => 'dbtext_subscriber_file'      , :value => '/etc/kamailio/db_text/subscriber' },
	{ :name => 'xml_rpc_host'                , :value => '127.0.0.1' },
	{ :name => 'xml_rpc_port'                , :value => '8080' },
	{ :name => 'xml_rpc_realm'               , :value => 'gemeinschaft' },
	{ :name => 'xml_rpc_user'                , :value => SecureRandom.hex(10) },
	{ :name => 'xml_rpc_password'            , :value => SecureRandom.hex(10) },
	{ :name => 'xml_rpc_timeout'             , :value => '20' },
	{ :name => 'fax_files_directory'         , :value => '/opt/gemeinschaft/misc/fax/' },
	{ :name => 'fax_max_files'               , :value => '2048' },
	{ :name => 'fax_max_duration'            , :value => '900' },
	{ :name => 'voicemail_max_record_length' , :value => '300' },
	{ :name => 'voicemail_min_record_length' , :value => '3' },
	{ :name => 'voicemail_max_files'         , :value => '2048' },
	{ :name => 'default_extension_length'    , :value => '3' },
	{ :name => 'snom_srtp'                    , :value => 'false' },
	{ :name => 'snom_transport_tls'           , :value => 'false' },
	{ :name => 'call_forward_max_hop'          , :value => '30' },
])


################################################################
# Nodes
################################################################

Node.create({
	# management_host must be reachable from all nodes, i.e.
	# "localhost" works if you have only 1 node.
	:management_host  => 'localhost',
	:management_port  => nil,  # default port
	:title            => 'Single-server dummy node',
})


################################################################
# Phone key function definitions
################################################################

# General softkey functions:
# DO NOT RENAME THEM! The name is magic and serves as an identifier! (#OPTIMIZE)
#
PhoneKeyFunctionDefinition.create([
	{ :name => 'BLF'              , :type_of_class => 'string'  , :regex_validation => nil },
	{ :name => 'Speed dial'       , :type_of_class => 'string'  , :regex_validation => nil },
	{ :name => 'ActionURL'        , :type_of_class => 'url'     , :regex_validation => nil },
	{ :name => 'Line'             , :type_of_class => 'integer' , :regex_validation => nil },
])


################################################################
# Manufacturers
################################################################

snom    = Manufacturer.find_or_create_by_ieee_name(
	'SNOM Technology AG', {
		:name => "SNOM Technology AG",
		:url  => 'http://www.snom.com/',
})
#aastra  = Manufacturer.find_or_create_by_ieee_name(
#	'DeTeWe-Deutsche Telephonwerke', {
#		:name => "Aastra DeTeWe",
#		:url  => 'http://www.aastra.de/',
#})
#tiptel  = Manufacturer.find_or_create_by_ieee_name(
#	'XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD', {
#		:name => "Tiptel",
#		:url  => 'http://www.tiptel.de/'
#})
#OPTIMIZE Differentiate between manufacturer and vendor. Make this either Yealink or Tiptel.


################################################################
# OUIs
################################################################

snom    .ouis.create([
	{ :value => '000413'},
])
#aastra  .ouis.create([
#	{ :value => '003042' },
#	{ :value => '00085D' },
#])
#tiptel  .ouis.create([
#	{ :value => '001565' },
#])




#OPTIMIZE Clean up the stuff in following ...



################################################################
# Phone models
################################################################

# Snom
# http://wiki.snom.com/Settings/mac
#

#snom.phone_models.create(:name => 'Snom 190').phone_model_mac_addresses.create(:starts_with => '00041322')

snom300 = snom.phone_models.create(:name => 'Snom 300', 
                                   :url => 'http://www.snom.com/en/products/ip-phones/snom-300/',
                                   :manual_url => 'http://wiki.snom.com/Snom300/Documentation',
                                   :max_number_of_sip_accounts =>  2 )
snom300.phone_model_mac_addresses.create([
                                         {:starts_with => '00041325'},
                                         {:starts_with => '00041328'},
                                         {:starts_with => '0004132D'},
                                         {:starts_with => '0004132F'},
                                         {:starts_with => '00041334'},
                                         {:starts_with => '00041350'},
                                         {:starts_with => '0004133B'},
                                         {:starts_with => '00041337'}
                                         ])

# Uncomment the following code if you need all Snom 300 MAC Addresses
# It'll fill your database by some 30,000 items.
#                                                                                
# ('0004133687F0'.hex .. '00041336FFFF'.hex).each do |snom300_mac_address|
#   snom300_mac_address = snom300_mac_address.to_s(16)
#   (snom300_mac_address.length .. 11).each do |i|
#     snom300_mac_address = '0' + snom300_mac_address
#   end
#   snom300.phone_model_mac_addresses.create(:starts_with => snom300_mac_address.upcase)
# end

snom.phone_models.create(:name => 'Snom 320', 
                         :url => 'http://www.snom.com/en/products/ip-phones/snom-320/',
                         :manual_url => 'http://wiki.snom.com/Snom320/Documentation',
                         :max_number_of_sip_accounts => 12,
                         :number_of_keys => 12 ).
                         phone_model_mac_addresses.create([
                           {:starts_with => '00041324'},
                           {:starts_with => '00041327'},
                           {:starts_with => '0004132C'},
                           {:starts_with => '00041331'},
                           {:starts_with => '00041335'},
                           {:starts_with => '00041338'},
                           {:starts_with => '00041351'}
                                         ])
snom.phone_models.create(:name => 'Snom 360', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-360/',
                        :manual_url => 'http://wiki.snom.com/Snom360/Documentation',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041323'},
                          {:starts_with => '00041329'},
                          {:starts_with => '0004132B'},
                          {:starts_with => '00041339'},
                          {:starts_with => '00041390'}
                                        ])
snom.phone_models.create(:name => 'Snom 370', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-370/',
                        :manual_url => 'http://wiki.snom.com/Snom370/Documentation',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041326'},
                          {:starts_with => '0004132E'},
                          {:starts_with => '0004133A'},
                          {:starts_with => '00041352'}
                                        ])
snom.phone_models.create(:name => 'Snom 820', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-820/',
                        :manual_url => 'http://wiki.snom.com/Snom820/Documentation',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
			phone_model_mac_addresses.create([
                          {:starts_with => '00041340'},
                                        ])
snom.phone_models.create(:name => 'Snom 821', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-821/',
                        :manual_url => 'http://wiki.snom.com/Snom821/Documentation',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041345'}
                                        ])
snom.phone_models.create(:name => 'Snom 870', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-870/',
                        :manual_url => 'http://wiki.snom.com/Snom870/Documentation',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041341'}
                                        ])
			
# Define Snom keys:
snom.phone_models.each do |pm|
	num_exp_modules = 0	
	max_key_idx = pm.number_of_keys.to_i + (42 * num_exp_modules) - 1
	if max_key_idx >= 0
		(0..max_key_idx).each { |idx|
			key = pm.phone_model_keys.create(
				{ :position => idx, :name => "P #{(1+idx).to_s.rjust(3,'0')} (fkey[#{idx}])" }
			)
			key.phone_key_function_definitions << PhoneKeyFunctionDefinition.all 
		}
	end
end

# Set http parameters
snom.phone_models.each do |phone_model|
  phone_model.update_attributes(:http_port => 80, :reboot_request_path => 'confirm.htm?REBOOT=yes', :http_request_timeout => 5)
end

# Set codecs for Snom
snom.phone_models.each do |phone_model|
  [ 'alaw', 'ulaw', 'gsm', 'g722', 'g726', 'g729', 'g723'
  ].each do |codec_name|
    phone_model.codecs << Codec.find_or_create_by_name(codec_name)
  end
end


## Aastra
##
#aastra.phone_models.create(:name => '57i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  30,  :url => 'http://www.aastra.com/aastra-6757i.htm')
#aastra.phone_models.create(:name => '55i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  26,  :url => 'http://www.aastra.com/aastra-6753i.htm')
#aastra.phone_models.create(:name => '53i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  6,   :url => 'http://www.aastra.com/aastra-6753i.htm')
#aastra.phone_models.create(:name => '51i',  :max_number_of_sip_accounts => 1, :number_of_keys =>  0,   :url => 'http://www.aastra.com/aastra-6751i.htm')
#
## Set http parameters
#aastra.phone_models.each do |phone_model|
#  phone_model.update_attributes(:http_port => 80, :reboot_request_path => 'logout.html', :http_request_timeout => 5, :default_http_user => 'admin',  :default_http_password => '22222', :random_password_consists_of => (0 ..9).to_a.join)
#end
#
#aastra.phone_models.each do |phone_model|
#  [ 'alaw', 'ulaw', 'g722', 'g726', 'g726-24', 'g726-32', 'g726-40', 'g729', 'bv16', 'bv32', 'ulaw-16k', 'alaw-16k', 'l16', 'l16-8k'
#  ].each do |codec_name|
#    phone_model.codecs << Codec.find_or_create_by_name(codec_name)
#  end
#end
#  
## Set softkeys
#['55i', '57i'].each do |p_model|
# (1..20).each { |mem_num| 
#    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.create([
#      { :name => "softkey#{mem_num}", :position => "#{mem_num}" }
#    ])
#    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.where( :name => "softkey#{mem_num}" ).first.phone_key_function_definitions << PhoneKeyFunctionDefinition.all
#
#  } 
#end
#
## Set topsoftkeys
#['57i'].each do |p_model|
# (1..10).each { |mem_num| 
#    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.create([
#      { :name => "topsoftkey#{mem_num}", :position => "#{mem_num+20}" }
#    ])
#    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.where( :name => "topsoftkey#{mem_num}" ).first.phone_key_function_definitions << PhoneKeyFunctionDefinition.all
#
#  } 
#end
#
## Tiptel
##
#
#tiptel.phone_models.create(:name => 'IP 286', :max_number_of_sip_accounts => 16, :number_of_keys => 10,  :url => 'http://www.tiptel.com/products/details/article/tiptel-ip-286-6/')
#tiptel.phone_models.create(:name => 'IP 280', :max_number_of_sip_accounts => 2, :url => 'http://www.tiptel.com/products/details/article/tiptel-ip-280-6/')
#tiptel.phone_models.create(:name => 'IP 284', :max_number_of_sip_accounts => 13, :number_of_keys => 10, :url => 'http://www.tiptel.com/products/details/article/tiptel-ip-284-6/')
#tiptel.phone_models.create(:name => 'VP 28', :url => 'http://www.tiptel.com/products/details/article/tiptel-vp-28-4/')
#tiptel.phone_models.create(:name => 'IP 28 XS', :url => 'http://www.tiptel.com/products/details/article/tiptel-ip-28-xs-6/')
#
## Set http parameters
#tiptel.phone_models.each do |phone_model|
#  phone_model.update_attributes(:http_port => 80, :reboot_request_path => '/cgi-bin/ConfigManApp.com', :http_request_timeout => 5, :default_http_user => 'admin',  :default_http_password => 'admin')
#end
#
## Codecs for Tiptel
#tiptel.phone_models.each do |phone_model|
#  [ "ulaw", "alaw", "g722", "g723", "g726", "g729", "g726-16", "g726-24", "g726-40"
#  ].each do |codec_name|
#    phone_model.codecs << Codec.find_or_create_by_name(codec_name)
#  end
#end
#
#['IP 284', 'IP 286'].each do |p_model|
#  (1..10).each { |mem_num| 
#    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.create([
#      { :name => "memory#{mem_num}", :position => "#{mem_num}" }
#    ])
#    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.where( :name => "memory#{mem_num}" ).first.phone_key_function_definitions << PhoneKeyFunctionDefinition.all
#
#  }
#end





Version.create(:table_name => "acc", :table_version => "4")
Version.create(:table_name => "missed_calls", :table_version => "3")
Version.create(:table_name => "lcr_gw", :table_version => "1")
Version.create(:table_name => "lcr_rule_target", :table_version => "1")
Version.create(:table_name => "lcr_rule", :table_version => "1")
Version.create(:table_name => "domain", :table_version => "1")
Version.create(:table_name => "grp", :table_version => "2")
Version.create(:table_name => "re_grp", :table_version => "1")
Version.create(:table_name => "trusted", :table_version => "5")
Version.create(:table_name => "address", :table_version => "4")
Version.create(:table_name => "aliases", :table_version => "1004")
Version.create(:table_name => "location", :table_version => "1004")
Version.create(:table_name => "silo", :table_version => "5")
Version.create(:table_name => "dbaliases", :table_version => "1")
Version.create(:table_name => "uri", :table_version => "1")
Version.create(:table_name => "speed_dial", :table_version => "2")
Version.create(:table_name => "usr_preferences", :table_version => "2")
Version.create(:table_name => "subscriber", :table_version => "6")
Version.create(:table_name => "pdt", :table_version => "1")
Version.create(:table_name => "dialog", :table_version => "5")
Version.create(:table_name => "dispatcher", :table_version => "4")
Version.create(:table_name => "dialplan", :table_version => "1")
Version.create(:table_name => "presentity", :table_version => "3")
Version.create(:table_name => "active_watchers", :table_version => "9")
Version.create(:table_name => "watchers", :table_version => "3")
Version.create(:table_name => "xcap", :table_version => "3")
Version.create(:table_name => "pua", :table_version => "6")
Version.create(:table_name => "rls_presentity", :table_version => "0")
Version.create(:table_name => "rls_watchers", :table_version => "1")
Version.create(:table_name => "imc_rooms", :table_version => "1")
Version.create(:table_name => "imc_members", :table_version => "1")
Version.create(:table_name => "cpl", :table_version => "1")
Version.create(:table_name => "sip_trace", :table_version => "2")
Version.create(:table_name => "domainpolicy", :table_version => "2")
Version.create(:table_name => "carrierroute", :table_version => "3")
Version.create(:table_name => "carrierfailureroute", :table_version => "2")
Version.create(:table_name => "carrier_name", :table_version => "1")
Version.create(:table_name => "domain_name", :table_version => "1")
Version.create(:table_name => "userblacklist", :table_version => "1")
Version.create(:table_name => "globalblacklist", :table_version => "1")
Version.create(:table_name => "htable", :table_version => "1")
Version.create(:table_name => "purplemap", :table_version => "1")
Version.create(:table_name => "uacreg", :table_version => "1")

Extension.create(:extension => "80", :destination => "-vmenu-", :active => true)
Extension.create(:extension => "90", :destination => "-park-in-", :active => true)
Extension.create(:extension => "99", :destination => "-park-out-", :active => true)


call_forward_reasons = ['busy', 'noanswer', 'offline', 'always', 'assistant']

call_forward_reasons.each do |reason|
	CallForwardReason.create(:value => reason)
end



################################################################
# Dialplan patterns
################################################################

DialplanPattern.create([
	{ :pattern => "xx."            , :name => "Alle Rufnummern" },
	{ :pattern => "0[1-9]xxx."     , :name => "Nationale Rufnummern" },
	{ :pattern => "00xx."          , :name => "Internationale Rufnummern" },
	{ :pattern => "[1-9]xx."       , :name => "Rufnummern im eigenen Ortsnetz" },
	{ :pattern => "090[0-5]xx."    , :name => "National: Mehrwertnummern / Premium-Rate-Dienste" },
	{ :pattern => "11[0-7]x."      , :name => "Notrufnummern etc." },
	{ :pattern => "19222"          , :name => "Notruf Rettungsdienst/Krankentransporte" },
	{ :pattern => "118x."          , :name => "Auskunftsdienste (u.U. teuer, koennen vermitteln)" },
	{ :pattern => "09009x."        , :name => "National: Mehrwertnummern (Dialer)" },
	{ :pattern => "09005x."        , :name => "National: Mehrwertnummern (Erwachsenenunterhaltung)" },
	{ :pattern => "0902x."         , :name => "National: Televoting (14 ct/Anruf)" },
	{ :pattern => "019[1-7]x."     , :name => "National: Internet-Zugaenge etc." },
	{ :pattern => "019[89]x."      , :name => "National: Routingnummern / netzinterne Verkehrslenkung" },
	{ :pattern => "080[01]x."      , :name => "National: Mehrwertnummern (kostenlos)" },
	{ :pattern => "01805x."        , :name => "National: Mehrwertnummern (Hotlines/Erwachsenenunterhaltung)" },
	{ :pattern => "01802001033x."  , :name => "National: Handvermittlung ins Ausland (teuer)" },
	{ :pattern => "0180x."         , :name => "National: Mehrwertnummern" },
	{ :pattern => "013[7-8]x."     , :name => "National: Televoting (25-100 ct/Anruf)" },
	{ :pattern => "012x."          , :name => "National: Innovative Dienste (teuer)" },
	{ :pattern => "031x."          , :name => "National: Testrufnummern" },
	{ :pattern => "032x."          , :name => "National: Ortsunabhaengige Teilnehmerrufnummern" },
	{ :pattern => "01[5-7]xx."     , :name => "National: Mobilfunk" },
#	{ :pattern => "018x."          , :name => "National: Nutzergruppen" },
	{ :pattern => "0180x."         , :name => "National: Geteilte-Kosten-Dienste" },
	{ :pattern => "0181x."         , :name => "National: Internationale Virtuelle Private Netze (IVPN)" },
	{ :pattern => "050[12]x."      , :name => "National: Telekommunikationsdienste" },
	{ :pattern => "06001x."        , :name => "National: Telekommunikationsdienste" },
	{ :pattern => "0601x."         , :name => "National: Telekommunikationsdienste" },
#	{ :pattern => "070[12]x."      , :name => "National: Persoenliche Rufnummern" },
])


################################################################
# Dialplan routes
################################################################

pat = DialplanPattern.where( :pattern => "xx." ).first
pat.dialplan_routes.create({ :eac => "0", :user_id => nil, :sip_gateway_id => nil, :name => "Beispiel" }) if pat



