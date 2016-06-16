require "socket"
require "pry"

def parse_params(text)
  params = text.split("&")
  rolls = params[0].sub("rolls=","")
  sides = params[1].sub("sides=","")
  {:rolls => rolls, :sides => sides}
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept
  
  request_line = client.gets
  puts request_line

  if (!request_line.include?("favicon"))
    items = request_line.split

    http_method = items[0]
    path = items[1].split("?")[0]
    params = parse_params(items[1].split("?")[1])

    client.puts http_method
    client.puts path
    params[:rolls].to_i.times do
      client.puts rand(params[:sides].to_i) + 1
    end
    client.close
  end
end

