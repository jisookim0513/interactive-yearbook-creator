require "koala"
require "live_paper"

ACCESS_TOKEN = "ID HERE"
LIVE_PAPER_ID = "ID HERE"
LIVE_PAPER_SECRET = "SECRET HERE"
SEARCH = "Judy Wang berkeley"
graph = Koala::Facebook::API.new(ACCESS_TOKEN)

# oauth = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET)
# new_access_info = oauth.exchange_access_token_info ACCESS_TOKEN


lst = graph.search(SEARCH, {:type => "user"})
# TODO: If lst has no elements, remove one search term and try again
# TODO: If lst has too many elements, give up
id = lst[0]["id"]
imageUrlString = graph.get_picture(id, {:height => "300", :width => "300"})

lp = LivePaper.auth({id: LIVE_PAPER_ID, secret: LIVE_PAPER_SECRET})
image = LivePaper::Image.upload imageUrlString
t = LivePaper::WmTrigger.create(name: 'watermark', watermark: {strength: 10, resolution: 75, imageURL: image})
redirectUrl = "http://www.facebook.com/" + id
p = LivePaper::Payoff.create(name: 'name', type: LivePaper::Payoff::TYPE[:WEB], url: redirectUrl)
l = LivePaper::Link.create(payoff_id: p.id, trigger_id: t.id, name: "link")
File.open("watermark.jpg","wb:UTF-8") { |f| f.write(t.download_watermark.force_encoding("UTF-8")) }
