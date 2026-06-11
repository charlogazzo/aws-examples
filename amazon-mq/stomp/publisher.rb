require "stomp"

login = ""
passcode = ""
host = ""
port = ""

config = { 
    hosts: [
        login: login, passcode: passcode, host: host, port: port, config: config
    ]}

client = Stomp::Client.new(config)

# define the destination and publish a message to the queue
dest = "/queue/test"
client.publish(dest, "Hello World!")
client.close
