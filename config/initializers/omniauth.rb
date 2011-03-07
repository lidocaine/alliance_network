Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'l5eph9FcALMj21QzCTBeHw', '59vOWS9sJrGqfsGhlZ7W5GXJcwoFd29Jmstr0OUhM'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end