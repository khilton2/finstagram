# FizzBuzz
# We're going to write a simple program together to continue to hone our Ruby skills. This one's a classic.

# Our code should do the following things:

# Make a list of numbers from 1 to 100, inclusive
# For each number, perform the following tests on it:
# FIZZ
# If the number is divisible by 3, output 'Fizz'

# BUZZ
# If the number is divisible by 5, output 'Buzz'

# FIZZBUZZ
# If the number is divisible by BOTH 3 and 5, output 'FizzBuzz'

# Feedback for this Task

#Steps:

#1.Make a list of numbers

num_list=(1..100)

#2.Loop through the list

num_list.each do |num|
    #num
    #3. If divisible by 3, say 'Fizz'
    
    if num % 3 ==0 && num % 5==0
        puts "#{num} FizzBuzz"
    elsif num % 5 == 0
        puts "#{num} Buzz"
    elsif num % 3 == 0
        puts "#{num} Fizz"
    else
        puts "#{num}"
    end
    
        
end