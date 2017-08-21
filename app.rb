require "sinatra"
enable "sessions"
get "/" do
	erb :names
end

post "/names" do
	session[:lname] = params[:lname]
 	redirect "/size"
end

get "/size" do
	erb :size, locals:[lname:session[:lname]]
end

post "/size" do
	size = params[:size]
	crust = params[:crust]
	meats = params[:meats]
	veggies = params[:veggies]
	special = params[:special]
end