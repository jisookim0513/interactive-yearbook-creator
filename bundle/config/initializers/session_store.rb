# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bundle_session',
  :secret      => 'd367dc9f1aa7e147e8c4917237ae4ae207304615a6f0e1d195d7218c0966365b7dc96ae4e04782f7076f28c04cea6b03a8f0d3e98033899bbaaa54f6bbbc329d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
