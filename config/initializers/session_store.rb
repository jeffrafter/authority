# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_authority_session',
  :secret      => 'de50d80d2a8cdff0514e5e8f4e81a8051c3b2f7dc7690d7556b7dabaa07fe85db781ecde1cc8d3f94c993fb6a718bba3486b825abd97e228e5526613a13d7d70'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
