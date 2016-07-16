require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @sort_text = "Sort Descending"
  @sort_link = "/descending" 
  @files = Dir.glob("public/*")
    .map {|item| File.basename(item)}.sort
  erb :home
end



get "/descending" do
  @sort_text = "Sort Ascending"
  @sort_link = "/" 
  @files = Dir.glob("public/*").map {|item| File.basename(item)}.sort.reverse
  erb :home
end