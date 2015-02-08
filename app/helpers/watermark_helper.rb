module WatermarkHelper
  Creds = {id: Rails.application.secrets.link_client_id,
           secret: Rails.application.secrets.link_client_secret }

  ACCESS_TOKEN = "CAACEdEose0cBABeDVg0hTHVqsNjeZAYyKMqbaO6bttXcKnexrwIcmDWT5W3horIHc96vPsROfZChuY1Lra7AdEkuIY63tyDcCD99PbsZCtointdpmXaL8nui0OMbFPogKfSbBqgvfThqJQSlp6hHdPa4Ozk2AXfZBvdeGWsCZBXHzRQOMW6v4y6zKEhykGncJca6N0QH5iKFKTkUup6QZBk8SK0iQ1A6wZD"
  
  def watermark(search, jpeg_url, output_file)
    graph = Koala::Facebook::API.new(ACCESS_TOKEN)
    search = search.split
    search = search.flat_map {|x| x.split("_")}
    lst = []
    while (search.count > 0) and (lst.count == 0) do
      lst = graph.search(search.join(" "), {:type => "user"})
      search.pop
    end
    if lst.count != 1
      return false
    end
    fb_name = lst[0]["name"]
    id = lst[0]["id"]
    fb_image_url = graph.get_picture(id, {:height => "300", :width => "300"})
    redirect_url = "http://www.facebook.com/" + id
    
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
  end

end
