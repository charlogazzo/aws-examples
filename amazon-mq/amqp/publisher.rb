require "bunny"

connection_string = "amqps://charles:Marvelous.13@b-3d3c02f0-b795-4fc1-b6b4-23a77dccd360.mq.eu-central-1.on.aws:5671"
connection = Bunny.new(connection_string)   
connection.start

channel = connection.create_channel
exchange = channel.default_exchange
queue = channel.queue("hello")

begin
    # Ensure the queue exists before publishing
    # queue.declare

    # Publish a message to the queue using the routing key (the queue name)
    exchange.publish("Hello, World!", routing_key: "hello")
    puts " [x] Sent 'Hello, World!'"
    channel.close
    connection.close


rescue => e
    puts e.inspect
    channel.close
    connection.close
    exit(1)
end
