# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mmfdstat_session',
  :secret      => '63738e687598aa66af2b87075e6d4473ba65d5551711a0fa24150aabea41ed61108c22f22ac609bcfd55e5ed41446b3a312c981114027b541908cee1b92f0502'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
