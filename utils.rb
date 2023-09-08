require 'colorize'

class Utils
  def color_puts(prompt, content, color)
    content_is_array = content.instance_of?(Array)
    output = !content_is_array && "#{prompt.colorize(:red)} #{content.colorize(color)}"
    if color.nil?
      puts output
    elsif !content_is_array
      puts output
    else
      puts "Examples: ".colorize(:red)
      content.each_with_index do |value, idx|
        puts "#{idx+1}. #{value.strip}".colorize(:green)
      end
    end
  end

  def clear
    system "clear"
  end
end