require_relative '../lib/solver'

puts 'Hello!'

puts 'Enter A'
a = gets.chomp.to_i
puts 'Enter B'
b = gets.chomp.to_i

puts "A+B is #{Solver.new.call(a, b)}"
