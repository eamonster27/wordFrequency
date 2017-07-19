class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    contents = File.read(filename)
    contents.gsub!(/[-,'.";]/,' ')
    contents.downcase!
    wordArray = contents.split(" ")
    STOP_WORDS.each do |excluded|
      wordArray.delete(excluded)
    end
    @filteredArray = wordArray.map do |word|
      word
    end
  end

  def frequency(word)
    @filteredArray.select{|target| target == word}.count
  end

  def frequencies
    wordFrequencyPairs = []
    @filteredArray.each do |word|
      wordFrequencyPairs << [word, frequency(word)]
    end
    filteredPairs = wordFrequencyPairs.uniq

    orderedPairs = filteredPairs.sort_by do |key, value|
      -(value)
    end
  end

  def top_words(number)
    wordFrequencyPairs = []
    @filteredArray.each do |word|
      wordFrequencyPairs << [word, frequency(word)]
    end
    filteredPairs = wordFrequencyPairs.uniq

    orderedPairs = filteredPairs.sort_by do |key, value|
      -(value)
    end
    orderedPairs.take(number)

  end

  def print_report
    top_words(10).each do |key, value|
      stars = "*" * value
      puts " #{key} | #{value} #{stars}"
    end
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
