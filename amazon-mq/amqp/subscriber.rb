require "bunny"

connection_string = "amqps://charles:Marvelous.13@b-3d3c02f0-b795-4fc1-b6b4-23a77dccd360.mq.eu-central-1.on.aws:5671"
connection = Bunny.new(connection_string)
connection.start

channel = connection.create_channel
queue = channel.queue("hello")

begin
    queue.subscribe(block: true) do |delivery_info, properties, body|
        puts " [x] Received '#{body}'"
    end

rescue => e
    channel.close
    connection.close
    exit(1)
end