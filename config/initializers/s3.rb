
# set credentials from ENV hash
S3_CREDENTIALS = { :access_key_id => Rails.application.secrets.aws_access_key_id,
                   :secret_access_key => Rails.application.secrets.aws_secret_key,
                   :bucket => "yearbook-creator"}
