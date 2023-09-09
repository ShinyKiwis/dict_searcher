require_relative "dict_searcher" 

dictSearcher = DictSearcher.new

begin
  loop do
    dictSearcher.run
  end
rescue Interrupt
  puts "Goodbye, happy learning!" 
rescue NoMethodError
  puts "Not a valid word!(Enter to continue)"
  gets
  retry  
end