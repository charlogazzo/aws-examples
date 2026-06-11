require "stomp"

login = ""
passcode = ""
host = ""
port = ""

config = { 
    hosts: [
        login: login,
        passcode: passcode,
        host: host,
        port: port,
        config: config
    ]}

client = Stomp::Client.new(config)
client.subscribe("/queue/test") do |msg|
    puts "Received message: #{msg.body}"
end
