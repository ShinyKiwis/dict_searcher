require 'httparty'
require 'nokogiri'

class WordScraper
  BASE_URL = 'https://www.oxfordlearnersdictionaries.com/definition/english/'
  def get_html(query_word) 
    response = HTTParty.get(BASE_URL + query_word)
    @document = Nokogiri::HTML(response.body)
  end

  def extract_info()
    word_form, word_level, word_definition, word_examples = 4.times.map { |i| get_info(['form', 'level', 'definition', 'examples'][i]) }
    [word_form, word_level, word_definition, word_examples]
  end

  def get_info(info)
    case info
    when 'form' 
      type = @document.at_xpath("//span[@class='pos']")
      if !type.nil?
        return type.children.text
      end
    when 'definition'
      definition = @document.at_xpath("//span[@class='def']")
      if !definition.nil?
        return definition.children.text
      end
    when 'level'
      level = @document.at_xpath("//div[@class='symbols']/a")
      if !level.nil?
        return level['href'][-2,2]
      end
    when 'examples'
      first_examples_ul = @document.xpath("//ul[@class='examples']")[0]
      examples_list = first_examples_ul.xpath(".//li")
      examples = []
      examples_list.each do |li|
        examples.append(li.text)
      end
      return examples
    end
    ""
  end
end