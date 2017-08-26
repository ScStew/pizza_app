require "sinatra"
require_relative "functions.rb"
enable "sessions"
get "/" do
	session[:final] = nil
	session[:final_price] = nil
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

	if pizza_meats == nil && session[:meats_p] != nil
		session[:meats_p] = nil
	elsif pizza_meats == nil
	else
	session[:meats_p] = seperator(pizza_meats)
	end
	
	if pizza_veggies == nil && session[:veggies_p] != nil
		session[:veggies_p] = nil
	elsif
	else
	session[:veggies_p] = seperator(pizza_veggies)
	end	

	if pizza_special == nil && session[:special_p] != nil
		session[:special_p] = nil
	elsif
	else
	session[:special_p] = seperator(pizza_special)
	end

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

post "/make_another" do
	pizza = params[:pizza]
	total = params[:total]
		
		if session[:final_price] == nil
			session[:final_price] = []
			session[:final_price] << total
		else
			session[:final_price] << total
		end
		
		if session[:final] == nil
			session[:final] = []
			session[:final] << pizza
		else
			session[:final] << pizza
		end
	redirect "/size"
end

post "/checkout" do
	pizza = params[:pizza]
	total = params[:total]
		if session[:final_price] == nil
			session[:final_price] = []
			session[:final_price] << total
		else
			session[:final_price] << total
		end

		if session[:final] == nil
			session[:final] = []
			session[:final] << pizza
		else
			session[:final] << pizza
		end
	redirect "/final_results"
end

get "/final_results" do
	p "#{session[:final]}"
	p "#{session[:final_price]}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	erb :final_page ,locals:{lname:session[:lname], delivery:session[:delivery], address:session[:address],final_price:session[:final_price],final:session[:final]}
end