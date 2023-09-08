require_relative "dict_searcher" 

dictSearcher = DictSearcher.new

begin
  loop do
    dictSearcher.run
  end
rescue Interrupt
  puts "Goodby, happy learning!" 
end