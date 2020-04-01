Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '354713532327-7rpiahucak6hck5spfn3lgblrcjlqi4p.apps.googleusercontent.com', '2PaVqK-i5F3RsDk9q1obc502'
  provider :linkedin, "81tbyjmjs8ol3r", "G6XqfqFWHs3V4T5r"
  provider :facebook, "266738217677296", "fdf1b9a2f3ac956543b5022d411d52ce"
end