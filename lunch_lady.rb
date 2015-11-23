# User chooses a main dish
def pass; end

class Lunch_lady
	def initialize

		@order = []
		@balance = 20.00

		@@main_dishes = [
			{"label" => "Chili", "cost" => 5.00},
			{"label" => "Mac-n-Cheese", "cost"  => 4.00},
			{"label" => "Fish sticks", "cost" => 3.00}
		]

		@@side_dishes = [
			{"label" => "Mashed potatoes", "cost" => 2.00},
			{"label" => "Cheese", "cost" => 1.0},
			{"label" => "Brussels sprouts", "cost" => 0.75}
		]
	end

	def main_dish
		while true
			puts "Choose a number for a main dish"
			@@main_dishes.each do |x|
				puts "#{@@main_dishes.index(x) + 1}. #{x["label"]}: $#{x["cost"]}"
			end
			puts "#{@@main_dishes.length + 1}. Exit"
			entree = gets.strip
			if /\A[-+]?\d+\z/.match(entree)
				entree = entree.to_i
				entree = entree - 1
				if @@main_dishes[entree] && @@main_dishes[entree]["cost"] <= @balance
					@balance -= @@main_dishes[entree]["cost"]
					return @@main_dishes[entree]
				elsif @@main_dishes[entree] && @@main_dishes[entree]["cost"] > @balance
					puts "You don't have enough money to get that!"
				elsif entree == @@main_dishes.length
					puts "Bye!"
					exit
				else
					puts "That is not a number on the menu."
				end
			end
			puts "Please enter a menu number."		
		end
	end

	# User chooses 2 side dish items
	def side_dish
		while true
			puts "Choose a number for a side dish"
			@@side_dishes.each do |x|
				puts "#{@@side_dishes.index(x) + 1}. #{x["label"]}: $#{x["cost"]}"
			end
			puts "#{@@side_dishes.length + 1}. Exit"
			side = gets.strip
			if /\A[-+]?\d+\z/.match(side)
				side = side.to_i
				side = side - 1
				if @@side_dishes[side] && @@side_dishes[side]["cost"] <= @balance
					@balance -= @@side_dishes[side]["cost"]
					return @@side_dishes[side]
				elsif @@side_dishes[side] && @@side_dishes[side]["cost"] > @balance
					puts "You don't have enough money to get that!"
				elsif side == @@side_dishes.length
					puts "Bye!"
					exit
				else
					puts "That number is not on the menu."
				end
			end
			puts "Please enter a menu number."	
		end
	end
	# computer repeats order
	def print_order
		puts "Your order:"
		@order.each do |x|
			puts "#{x["label"]}: $#{x["cost"]}"
		end
	end

	# user has a wallet total
	# display total cost
	def print_wallet
		puts "\n\n\n"
		puts "Your balance:   #{@balance.round(2)}"
	end

	def total_cost
		sum = 0
		@order.each do |x|
			sum += x["cost"]
		end
		puts "Your total goes out to #{sum.round(2)}."
	end
	
	# choose to add on items
	def addon?()
		puts "Would you like to add any other items? y/n"
		while true
			exit_status = gets.strip.downcase
			if exit_status == "y"
				return true
			elsif exit_status == "n"
				return false
			else
				puts "Please enter either y to add an item or n to quit."
			end
		end
	end

	def clear?()
		puts "Do you want me to clear the order? y/n"
		while true
			exit_status = gets.strip.downcase
			if exit_status == "y"
				clear_choices
				return true
			elsif exit_status == "n"
				return false
			else
				puts "Please enter either y to add an item or n to clear the order."
			end
		end
	end

	def main_or_side(add)
			
			if add == true
				choice = nil
				while true
					print_order
					print_wallet
					puts "Do you want to add a main or a side dish?"
					puts "1. Main dish"
					puts "2. Side dish"
					puts "3. Proceed to checkout"

					choice = gets.strip
					case choice
					when "1"
						@order << main_dish
					when "2"
						@order << side_dish
					when "3"
						return true
					else
						choice = nil
						puts "Please choose whether you want to add a main or side dish."
					end
				end
			end
			return true
	end

	# clear choices and start over
	def clear_choices
		@order.clear
		@balance = 20.00

	end

	def primary_order
		print_wallet
		@order << main_dish
		print_order
		print_wallet
		@order << side_dish
		print_order
		print_wallet
		puts "What do you want for another side dish?"
		@order << side_dish
		print_order
		print_wallet
	end

	def complete_order
		puts "Hi I'm the lunch lady."
		primary_order	
		main_or_side(addon?)
	end

	def lunch
		ordering = true
		while ordering == true
			complete_order
			ordering = clear?
		end

		total_cost
		puts "Here is your order."
		print_order
	end
end	

lady = Lunch_lady.new
lady.lunch




