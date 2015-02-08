module WatermarkHelper
  Creds = {id: Rails.application.secrets.link_client_id,
           secret: Rails.application.secrets.link_client_secret }

  def add_watermark(image_id)
    lp = LivePaper.auth(Creds)

  end

end
