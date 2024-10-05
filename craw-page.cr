require "dotenv"
require "http/client"
require "amqp-client"

Dotenv.load?
lavinmq_url = ENV["LAVINMQ_URL"]?

abort "LAVINMQ_URL is not set" if lavinmq_url.nil?

url = ARGV[0]?


if url.nil?
  abort "Usage: script <url>"
end

response = HTTP::Client.get(url)

regex = /a href="([http|https][^"]+)"/

links = response.body.scan(regex)

AMQP::Client.start(lavinmq_url) do |c|
    c.channel do |ch|
        q = ch.queue("urls")
        links.each do |link|
            q.publish_confirm link[1]
        end
    end
end
