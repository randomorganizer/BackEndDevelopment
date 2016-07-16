require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require "yaml"
require "pry"

before do
  @users = YAML.load_file("users.yaml")
end

helpers do
  def count_interests(users)
    users.inject(0) do |sum, item|
      sum += item[1][:interests].count
    end
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/users/:name" do
  @user = @users[params[:name].to_sym]
  @other_users = @users.select{ |k,v| k != params[:name].to_sym}
  erb :user_detail
end