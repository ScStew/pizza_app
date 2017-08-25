require "sinatra"
require_relative "functions.rb"
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
	pizza_size	= params[:size]
	pizza_crust = params[:crust]
	pizza_meats = params[:meats]
	pizza_veggies = params[:veggies]
	pizza_special = params[:special]

	session[:size] = single_seperator(pizza_size) 
	session[:crust] = single_seperator(pizza_crust)
	session[:meats] = seperator(pizza_meats)
	session[:veggies] = seperator(pizza_veggies)
	session[:special] = seperator(pizza_special)
	redirect "/confirm"
end

get "/confirm" do 
	erb :confirm, locals: {size:session[:size],crust:session[:crust], meats:session[:meats],veggies:session[:veggies], special:session[:special]}
end

post "/back" do
	redirect "/"
end

post "/confirm" do
	mea = params[:meats]
	veg = params[:veggies]
	spe = params[:special]
	session[:price] = params[:price]
	session[:total_for_one] = total_cost(session[:price])

		if mea == nil

		else
		session[:meats]= mea.values
		end

	if veg == nil

	else
	session[:veggies] = veg.values
	end

		if spe == nil

		else
		session[:special] = spe.values
		end
	
	redirect "/delivery"
end

get "/delivery" do
	erb :delivery
end

post "/delivery" do
	delivery = params[:delivery]
	if delivery == "delivery"
		redirect "/address?"
	else
		redirect "/results?delivery=" + delivery
	end
end


get "/address" do
	erb :address
end

post "/address" do 
	delivery = params[:delivery]
	address = params[:address]
	redirect "/results?delivery=" + delivery + "&address=" + address
end

get "/results" do
	delivery = params[:delivery]
	address = params[:address]
	erb :results, locals:{price:session[:price],crust:session[:crust],size:session[:size],meats:session[:meats],veggies:session[:veggies],special:session[:special],delivery:delivery,address:address}
end
