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
	erb :size, locals: {lname:session[:lname]}
end

post "/size" do
	session[:size] = params[:size]
	session[:crust] = params[:crust]
	session[:meats] = params[:meats]
	session[:veggies] = params[:veggies]
	session[:special]= params[:special]
	redirect "/confirm"
end

get "/confirm" do 
	erb :confirm, locals: {size:session[:size],crust:session[:crust], meats:session[:meats],veggies:session[:veggies], special:session[:special]}
end