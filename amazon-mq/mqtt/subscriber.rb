require "mqtt"

require "mqtt"

host = "localhost"
topic = "test/topic"

begin
    MQTT::Client.connect(host) do |client|
        client.get(topic) do |topic, message|
            puts "Received message on topic '#{topic}': #{message}"
        end
    end
rescue => e
    puts e.inspect
end