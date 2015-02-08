module WatermarkHelper
  Creds = {id: Rails.application.secrets.link_client_id,
           secret: Rails.application.secrets.link_client_secret }

  ACCESS_TOKEN = Rails.application.secrets.facebook_token

  def get_facebook_info_from_url(url):
    url = url.split("/")[-1]
    url = url.split("?")[0]
    graph = Koala::Facebook::API.new
    result = graph.get_object(url)
    fb_name = result["name"]
    fb_id = result["id"]
    fb_image_url = graph.get_picture(fb_id, {:height => "300", :width => "300"})
    return [fb_name, fb_id, fb_image_url]
  end

  def extract_facebook_info(id_name_dict, graph)
    fb_name = id_name_dict["name"]
    fb_id = id_name_dict["id"]
    fb_image_url = graph.get_picture(fb_id, {:height => "300", :width => "300"})
    return [fb_name, fb_id, fb_image_url]
  end

  def get_facebook_info(search)
    begin
      graph = Koala::Facebook::API.new(ACCESS_TOKEN)
      search = search.split
      search = search.flat_map {|x| x.split("_")}
      lst = []
      while (search.count > 0) and (lst.count == 0) do
        lst = graph.search(search.join(" "), {:type => "user"})
        search.pop
      end
      if lst.count > 3
        return []
      else
        return lst.map {|x| extract_facebook_info(x, graph)}
      end
    rescue
      return []
    end
  end
  
  def watermark(fb_info, jpeg_url, output_file)
    begin
      fb_name = fb_info[0]
      fb_id = fb_info[1]
      fb_image_url = fb_info[2]
      redirect_url = "http://www.facebook.com/" + fb_id
    
      lp = LivePaper.auth({id: Creds[:id], secret: Creds[:secret]})
      image = LivePaper::Image.upload jpeg_url
      t = LivePaper::WmTrigger.create(name: 'watermark', watermark: {strength: 10, resolution: 75, imageURL: image})

      dataDict = {
        type: "content action layout",
        version: "1",
        data: {
          content: {
            type: "image",
            label: fb_name,
            data: {
              URL: fb_image_url
            }
          },
          actions:[
            {
              type: "webpage",
              label: "Facebook",
              icon: {id: "536"},
              data: {URL: redirect_url}
            }
          ]
        }
      }

      p = LivePaper::Payoff.create(name: 'name', type: LivePaper::Payoff::TYPE[:RICH], url: fb_image_url, data_type: "custom-base64", data: dataDict)
      
      l = LivePaper::Link.create(payoff_id: p.id, trigger_id: t.id, name: "link")
      File.open(output_file,"wb:UTF-8") { |f| f.write(t.download_watermark.force_encoding("UTF-8")) }
      return true
    rescue
      puts "Error during watermarking"
      return false
    end
  end

end
