# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Gemeinschaft4::Application.initialize!




#OPTIMIZE Are the constants in following still used?
# See https://github.com/amooma/Gemeinschaft4/commit/5578a080873a01ce86202e151f365c72be53adf0


DOMAIN = '127.0.0.1'

AUTH_DB_ENGINE = 'odbc'

if (Rails.env.production?)
  DBTEXT_SUBSCRIBER_FILE = '/etc/kamailio/db_text/subscriber'
elsif (Rails.env.test?)
  DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber.test'
else
  DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber.test'
end

XML_RPC_HOST = '127.0.0.1'
XML_RPC_PORT = 8080
XML_RPC_USER = 'freeswitch'
XML_RPC_PASSWORD = 'works'

FAX_FILES_DIRECTORY = '/opt/gemeinschaft/misc/fax/'
#TODO Check that this directory is actually created somewhere?

