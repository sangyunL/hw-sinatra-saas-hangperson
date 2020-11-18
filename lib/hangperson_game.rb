class HangpersonGame
  
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
   
  def initialize(word)  
    @word = word       #초기화 word:정답 
    @guesses=''         #guesses : 예상한것 알파벳 목록
    @wrong_guesses=''   #wrong_guesses : 틀린 알파벳 목
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  
  def guess(letter)
    raise ArgumentError if letter=="" || letter==nil || !letter.match(/[A-Za-z]/)
    #return true if letter=="" || letter==nil || !letter.match(/[A-Za-z]/)
    letter.downcase!
    if @word.include? letter
      if not @guesses.include? letter
        @guesses += letter
      else
        return false
      end
    else
      if not @wrong_guesses.include? letter
        @wrong_guesses += letter
      else
        return false
      end
    end
  end
  
  def word_with_guesses
    display = ''
    word = @word.split(//)
    word.each do |letter|
      if @guesses.include? letter
        display += letter
      else
        display += '-'
      end
    end
    return display
  end
  
  def check_win_or_lose
    if wrong_guesses.size >= 7
      return :lose
    elsif word_with_guesses == @word and wrong_guesses.size < 7 
      return :win
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
end