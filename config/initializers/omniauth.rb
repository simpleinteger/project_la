Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '481107595238.apps.googleusercontent.com', 'CukfOXwCw1FineI-6_5_Hl5k', {
        access_type: 'offline',
        scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
        redirect_uri:'http://localhost/auth/google_oauth2/callback'
      }
end

