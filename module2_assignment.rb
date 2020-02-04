class LineAnalyzer

  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency(@content)
  end

  def calculate_word_frequency(line)
    hasher = Hash.new(0)
    line.downcase.split.each do |word|
      hasher[word]  = hasher[word] + 1
    end
    #puts "#{hasher}\n\n"

    @highest_wf_count = hasher.max_by {|k,v| v}[1]
    @highest_wf_words = hasher.select {|k,v| v == @highest_wf_count}.keys
    #puts "#{@highest_wf_count} , #{@highest_wf_words}"
  end
end
  
class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file
    File.open('test.txt') do |f|
      f.each_line.with_index do |line,index|
        @analyzers << LineAnalyzer.new(line,index + 1)
      end
    end
  end

  def calculate_line_with_highest_frequency
    temp = []
    p @highest_count_across_lines
    @analyzers.each { |x| temp << x.highest_wf_count}
    @highest_count_across_lines = temp.max
    p @highest_count_across_lines
    @highest_count_words_across_lines = @analyzers.select {|x| x.highest_wf_count == @highest_count_across_lines}
    print_highest_word_frequency_across_lines
  end

  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each {|obj| puts "#{obj.highest_wf_words}, Line Number = #{obj.line_number}"}
  end

end



