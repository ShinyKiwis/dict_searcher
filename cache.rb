require 'yaml'
require 'pry'

class Cache

  def initialize
    @file_path = 'words.yaml'
    @word_list = load
  end

  def deep_stringify_keys(query_word, hash_data)
    {
      query_word.to_s => hash_data[query_word].transform_keys(&:to_s)
    }
  end

  def get(query_word)
    if !@word_list.nil?
      return @word_list[query_word]
    end
  end

  def load
    YAML.load_file(@file_path) if File.exist?(@file_path)
  end

  def save(query_word, word_info)
    word_form, word_level, word_definition, word_examples = word_info
    data = {
      query_word.to_s => {
        form: word_form,
        level: word_level,
        definition: word_definition,
        examples: word_examples
      }  
    }
    File.open(@file_path, 'a') do |file|
      file << deep_stringify_keys(query_word,data).to_yaml(line_width: -1).gsub("---\n", "")
    end
    @word_list = load
  end
end