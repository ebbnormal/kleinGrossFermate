class Generator < ActiveRecord::Base
  has_many :scores

  def calculate_posterior_numerator_postive(event_array)
    product = 1.0
    event_array.each_with_index do |event_n, n|
      event_variance_symbol = "event#{n + 1}_variance".to_sym
      event_mean_symbol = "event#{n + 1}_mean".to_sym
      variance  = read_attribute event_variance_symbol
      mean = read_attribute event_mean_symbol
      if variance == 0.0
        product = product * 1**(-(event_n - mean)**2)
      else
        product = product * (1 / Math.sqrt(2 * Math::PI) * variance)**( -(event_n - mean)**2/(2 * variance) ) 
      end
    end
    product
  end

  def calculate_posterior_numerator_negative(event_array)
    product = 1.0
    event_array.each_with_index do |event_n, n|
      event_variance_symbol = "event#{n + 1}_negative_variance".to_sym
      event_mean_symbol = "event#{n + 1}_negative_mean".to_sym
      variance = read_attribute event_variance_symbol
      mean = read_attribute event_mean_symbol
      if variance == 0.0
        product = product * 1**(-(event_n - mean)**2)
      else
        product = product * (1 / Math.sqrt(2 * Math::PI) * variance)**(-(event_n - mean)**2 / (2 * variance)) 
      end
    end
    product
  end

  def generate_score
    meets_model_criteria = false
    new_score = Array.new(8)
    until meets_model_criteria == true
      #randomly generate 8 sonic events
      prng = Random.new(Time.now.to_i)
      (0..7).each do |n|
        new_score[n] = prng.rand(3) + 1
      end
      
      #calculate respective probabilities for being in the model's class and
      #and for not belonging in the class
      posterior_positive = calculate_posterior_numerator_postive(new_score)
      posterior_negative = calculate_posterior_numerator_negative(new_score)
      if posterior_positive > posterior_negative
        meets_model_criteria = true
      end
    end

    new_score
  end

  def calculate_mean(data, n)
  	sum = 0
    data["event_#{n}"].each do |x|
      sum = sum + x.to_i
    end

    if data["event_#{n}"].length != 0
      mean = sum / data["event_#{n}"].length
    else
      0
    end
  end

  def calculate_variance(data, n, mean)
    sum_of_square_difference = 0
    data["event_#{n}"].each do |x|
      sum_of_square_difference = sum_of_square_difference + (x.to_i - mean)**2
    end
    
    if data["event_#{n}"].length != 0
      variance = sum_of_square_difference.to_f / data["event_#{n}"].length.to_f
    else
      0
    end
  end

  def calculate_model(hash)
    (1..8).each do |n|
      n_label_string = "score_#{n}_label"
      update_attribute(n_label_string, hash[n_label_string])
    end
    
    positive_training_data = Hash.new()
    (1..8).each do |n|
      positive_training_data["event_#{n}"]  = []
    end
    
    negative_training_data = Hash.new()
    (1..8).each do |n|
      negative_training_data["event_#{n}"]  = []
    end

    #label the data as positive or negative
    (1..8).each do |i|
      if hash["score_#{i}_label"]== "true"
        (1..8).each do |n|
          positive_training_data["event_#{n}"].push(hash["score_#{i}_event_#{n}".to_sym]) 
        end
      else
        (1..8).each do |n|
          negative_training_data["event_#{n}"].push(hash["score_#{i}_event_#{n}".to_sym]) 
        end
      end
    end

    
    (1..8).each do |n|
      event_n_mean = "event#{n}_mean".to_sym
      event_n_variance = "event#{n}_variance".to_sym

      event_n_negative_mean = "event#{n}_negative_mean".to_sym
      event_n_negative_variance = "event#{n}_negative_variance".to_sym

      mean = calculate_mean(positive_training_data, n)
      variance = calculate_variance(positive_training_data, n, mean)
      
      negative_mean = calculate_mean(negative_training_data, n)
      negative_variance = calculate_variance(negative_training_data, n, mean)

      update_attribute(event_n_mean, mean)
      update_attribute(event_n_variance, variance)

      update_attribute(event_n_negative_mean, negative_mean)
      update_attribute(event_n_negative_variance, negative_variance)
    end

  end
end
