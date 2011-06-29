module ApplicationHelper
	
	# Define the top navigation menu items
	#
	def top_menu_items
		if user_signed_in?
			menu_items = [
				
				{ :text => "Admin"         , :url => admin_index_path },
				
				{ :text => "Accounts", :sub => [
					{ :text => "Users"         , :url => admin_users_path },
					{ :text => "SIP Accounts"  , :url => sip_accounts_path },
					{ :text => "Call Forwards" , :url => call_forwards_path },
				]},
				
				{ :text => "Phones"        , :url => phones_path },
				
				{ :text => "Extensions"    , :url => extensions_path },
				
				{ :text => "Media services", :sub => [
					{ :text => "Queues"        , :url => call_queues_path },
					{ :text => "Conferences"   , :url => conferences_path },
					{ :text => "Fax Documents" , :url => fax_documents_path },
				]},
				
				{ :text => "Servers", :sub => [
					{ :text => "SIP Domains"       , :url => sip_servers_path },
					{ :text => "SIP Proxies"       , :url => sip_proxies_path },
					{ :text => "Voicemail Servers" , :url => voicemail_servers_path },
					{ :text => "Nodes"             , :url => nodes_path },
				]},
				
				{ :text => "Help"          , :url => admin_help_path }
				
			]
		else
			menu_items = [
				{ :text => "Sign in"       , :url => new_user_session_path }
			]
		end
		return menu_items
	end
	
	def page_title( page_title )
		content_for(:page_title) { page_title }
	end
	
end

