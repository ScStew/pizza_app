require "sinatra"
enable "sessions"
get "/" do
	erb :names
end

post "/names" do
	session[:fname] = params[:fname]
	session[:lname] = params[:lname]
 	"work in progress"
end