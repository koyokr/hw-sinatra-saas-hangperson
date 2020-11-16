class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_reader :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'mockdata'
    Mockdata::Words.one
    # require 'uri'
    # require 'net/http'
    # uri = URI('http://watchout4snakes.com/Random/RandomWord')
    # Net::HTTP.new('watchout4snakes.com').start { |http|
    #   return http.post(uri, "").body
    # }
  end

  def guess(c)
    raise ArgumentError.new if c.nil? or !/[A-Za-z]/.match? c
    c.downcase!
    return false if @guesses.include? c or @wrong_guesses.include? c
    if @word.include? c
      @guesses += c
    else
      @wrong_guesses += c
    end
    true
  end

  def word_with_guesses
    @word.chars.map { |c| if @guesses.include? c then c else '-' end }.join
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if self.word_with_guesses == @word
    return :play
  end
end
