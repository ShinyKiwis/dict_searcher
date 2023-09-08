require_relative 'word_scraper'
require_relative 'utils'

class DictSearcher
  def initialize
    @scraper = WordScraper.new
    @utils = Utils.new
  end

  def display(query_word)
    @utils.clear
    word_form, word_level, word_definition, word_examples = @scraper.extract_info
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
    @scraper.get_html(query_word)
    display(query_word)
    gets
  end
end