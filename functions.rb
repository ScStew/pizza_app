def seperator(arr)
	final_arr = []
	arr.each do |x|
		new_arr = x.split(",")
		new_hash = {new_arr[0] => new_arr[1].to_f}
		final_arr << new_hash
	end
	p final_arr
	final_arr
end

def single_seperator(arr)
	x = arr.split(",")
	new_hash = {x[0] => x[1].to_f}
	new_hash
end
