require "koala"
require "live_paper"

ACCESS_TOKEN = "ID HERE"
LIVE_PAPER_ID = "ID HERE"
LIVE_PAPER_SECRET = "SECRET HERE"
SEARCH = "Pierre Karashchuk berkeley"
INPUT_PICTURE = "http://graph.facebook.com/rohinmshah/picture?width=300&height=300"

graph = Koala::Facebook::API.new(ACCESS_TOKEN)

# oauth = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET)
# new_access_info = oauth.exchange_access_token_info ACCESS_TOKEN


lst = graph.search(SEARCH, {:type => "user"})
fbName = lst[0]["name"]
id = lst[0]["id"]
imageUrlString = graph.get_picture(id, {:height => "300", :width => "300"})
redirectUrl = "http://www.facebook.com/" + id

lp = LivePaper.auth({id: LIVE_PAPER_ID, secret: LIVE_PAPER_SECRET})
image = LivePaper::Image.upload INPUT_PICTURE
t = LivePaper::WmTrigger.create(name: 'watermark', watermark: {strength: 10, resolution: 75, imageURL: image})

#p = LivePaper::Payoff.create(name: 'name', type: LivePaper::Payoff::TYPE[:WEB], url: redirectUrl)

dataDict = {
  type: "content action layout",
  version: "1",
  data: {
    content: {
      type: "image",
      label: fbName,
      data: {
        URL: imageUrlString
      }
    },
    actions:[
      {
        type: "webpage",
        icon: {id: "533"},  # TODO: Replace with FB icon
        data: {URL: redirectUrl}
      }
    ]
  }
}

p = LivePaper::Payoff.create(name: 'name', type: LivePaper::Payoff::TYPE[:RICH], url: imageUrlString, data_type: "custom-base64", data: dataDict)

l = LivePaper::Link.create(payoff_id: p.id, trigger_id: t.id, name: "link")
File.open("watermark.jpg","wb:UTF-8") { |f| f.write(t.download_watermark.force_encoding("UTF-8")) }
