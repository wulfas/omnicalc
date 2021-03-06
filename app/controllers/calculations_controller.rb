class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length


    @character_count_without_spaces = @text.length - @text.count(" ") - @text.count("\n") - @text.count("\r")


    @word_count = @text.split.count

    @occurrences = @special_word.split.count

  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    apr_decimal = @apr/100/12
    months = @years*-12
    num = apr_decimal*@principal
    den = 1-((1+apr_decimal)**months)
    @monthly_payment =  num/den
  end


  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @months = @days / 30
    @years = @days / 365
  end



  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @sorted_numbers.last - @sorted_numbers.first

    if @count.odd? == true
      midpoint_odd = (@count / 2)
      @median = @sorted_numbers[midpoint_odd]
    else
      midpoint_even_low = (@count / 2)-1
      midpoint_even_high = (@count / 2)
      @median = (@sorted_numbers[midpoint_even_low] + @sorted_numbers[midpoint_even_high])/2
    end

    @sum = @numbers.inject(:+)

    @mean = @sum / @count

    all_squared = []
    @numbers.each do |num|
      indiv_squared = (num - @mean)**2
      all_squared.push(indiv_squared)
    end

    @variance = all_squared.sum / all_squared.count

    @standard_deviation = @variance**0.5

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = @numbers.max_by { |v| freq[v] }

  end
end
