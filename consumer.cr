require "dotenv"
require "amqp-client"
require "http/client"

Dotenv.load?

lavinmq_url = ENV["LAVINMQ_URL"]?

abort "LAVINMQ_URL is not set" if lavinmq_url.nil?

query_pattern = ARGV[0]?
if query_pattern.nil?
  abort "Please provide a pattern to search for."
end

AMQP::Client.start(lavinmq_url) do |c|
  c.channel do |ch|
    q = ch.queue("urls")
    puts "Waiting for messages to search for #{query_pattern}. To exit press CTRL+C"
    q.subscribe(block: true) do |msg|
      url = msg.body_io.to_s
      puts "====="
      puts "Crawling: #{url}"
      response = HTTP::Client.get(url)
      if response.status_code == 200 && response.body.includes?(query_pattern)
        puts response.body
      else
        puts "Pattern not found!"
      end
    end
  end
end