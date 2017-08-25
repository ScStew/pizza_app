require "sinatra"
require_relative "functions.rb"
enable "sessions"
get "/" do
	erb :names
end

post "/names" do
	session[:lname] = params[:lname]
 	redirect "/delivery"
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

	session[:size_p] = single_seperator(pizza_size) 
	session[:crust_p] = single_seperator(pizza_crust)
	session[:meats_p] = seperator(pizza_meats)
	session[:veggies_p] = seperator(pizza_veggies)
	session[:special_p] = seperator(pizza_special)
	redirect "/confirm"
end

get "/confirm" do 
	erb :confirm, locals: {size:session[:size_p],crust:session[:crust_p], meats:session[:meats_p],veggies:session[:veggies_p], special:session[:special_p]}
end

post "/back" do
	redirect "/"
end

post "/confirm" do
	mea = params[:meats]
	veg = params[:veggies]
	spe = params[:special]
	price = params[:price]
	session[:total_for_one] = total_cost(price)

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
	
	redirect "/results"
end

get "/delivery" do
	erb :delivery
end

post "/delivery" do
	session[:delivery] = params[:delivery]
	if session[:delivery] == "delivery"
		redirect "/address?"
	else
		redirect "/size"
	end
end


get "/address" do
	erb :address
end

post "/address" do 
	session[:address] = params[:address]
	redirect "/size"
end

get "/results" do
	erb :results, locals:{total:session[:total_for_one],crust:session[:crust_p],size:session[:size_p],meats:session[:meats_p],veggies:session[:veggies_p],special:session[:special_p]}
end

