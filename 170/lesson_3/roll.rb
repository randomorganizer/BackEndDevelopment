require "socket"
require "pry"

def parse_params(text)
  return {:rolls => 1, :sides => 1} if text.nil?
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

  next unless request_line

  if (!request_line.include?("favicon"))
    items = request_line.split

    http_method = items[0]
    path = items[1].split("?")[0]
    params = parse_params(items[1].split("?")[1])

    client.puts "HTTP/1.0 200 OK"
    client.puts "Content-Type: text/html"
    client.puts
    client.puts "<html>"
    client.puts "<body>"
    client.puts "<pre>"
    client.puts http_method
    client.puts path
    client.puts "</pre>"
    client.puts "<h1>Rolls!</h1>"
    params[:rolls].to_i.times do
      client.puts "<p>", rand(params[:sides].to_i) + 1, "</p>"
    end
    client.puts "</body>"
    client.puts "</html>"
    client.close
  end
end

