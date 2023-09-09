require_relative 'word_scraper'
require_relative 'utils'
require_relative 'cache'

class DictSearcher
  def initialize
    @scraper = WordScraper.new
    @utils = Utils.new
    @cache = Cache.new
  end

  def display(query_word, cache_result)
    @utils.clear
    if cache_result.nil?
      word_form, word_level, word_definition, word_examples = @scraper.extract_info 
    else
      word_form = cache_result["form"]
      word_level = cache_result["level"]
      word_definition = cache_result["definition"]
      word_examples = cache_result["examples"]
    end
    @utils.color_puts("Your word:  ", query_word.capitalize, :blue)
    @utils.color_puts("Word form:  ", word_form.capitalize, :blue)
    @utils.color_puts("Word level: ", word_level.upcase, :blue)
    @utils.color_puts("Definition: ", word_definition.capitalize, :blue)
    @utils.color_puts("Examples:   ", word_examples, :blue)
  end

  def run
    @utils.clear
    print "Input your word: "
    query_word = gets.chomp

    # Check if word list has already contain this words
    cache_result = @cache.get(query_word)
    if !cache_result.nil?
      puts cache_result.inspect
    else
      @scraper.get_html(query_word)
    end
    display(query_word, cache_result)

    puts "Do you want to add this to your learning list ? (Y/n)" if cache_result.nil?
    answer = gets.chomp if cache_result.nil?
    if answer&.downcase == 'y' || answer&.downcase == 'yes'
      puts "Saving to words.yaml..."
      @cache.save(query_word, @scraper.extract_info)
    end
    puts "Enter to continue."
    gets
  end
end