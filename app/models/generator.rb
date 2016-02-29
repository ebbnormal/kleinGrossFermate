class Generator < ActiveRecord::Base
  has_many :scores

  def calculate_posterior_numerator_postive(event_array)
    product = 1.0
    event_array.each_with_index do |event_n, n|
      event_variance_symbol = "event#{n+1}_variance".to_sym
      event_mean_symbol = "event#{n+1}_mean".to_sym
      variance  = read_attribute event_variance_symbol
      mean = read_attribute event_mean_symbol
      if variance == 0.0
        product = product * 1**(-(event_n - mean)**2)
      else
        product = product * (1/Math.sqrt(2*Math::PI)*variance)**(-(event_n - mean)**2/(2*variance)) 
      end
    end
    product
  end

  def calculate_posterior_numerator_negative(event_array)
    product = 1.0
    event_array.each_with_index do |event_n, n|
      event_variance_symbol = "event#{n+1}_negative_variance".to_sym
      event_mean_symbol = "event#{n+1}_negative_mean".to_sym
      variance  = read_attribute event_variance_symbol
      mean = read_attribute event_mean_symbol
      if variance == 0.0
        product = product * 1**(-(event_n - mean)**2)
      else
        product = product * (1/Math.sqrt(2*Math::PI)*variance)**(-(event_n - mean)**2/(2*variance)) 
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
      new_score[0] = prng.rand(3)+1
      new_score[1] = prng.rand(3)+1
      new_score[2] = prng.rand(3)+1
      new_score[3] = prng.rand(3)+1
      new_score[4] = prng.rand(3)+1
      new_score[5] = prng.rand(3)+1
      new_score[6] = prng.rand(3)+1
      new_score[7] = prng.rand(3)+1
      
      #calculate respective probabilities for being in the model's class and
      #and for not belonging in the class
      posterior_positive = calculate_posterior_numerator_postive(new_score)
      posterior_negative = calculate_posterior_numerator_negative(new_score)
      #Rails.logger.debug("Posterior positive is #{posterior_positive}")
      #Rails.logger.debug("Posterior negative is #{posterior_negative}")
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
      Rails.logger.debug("Hash label at #{n} is #{hash[n_label_string]}") 
      #
      #value = nil
      #if hash[n_label_symbol] == "false"
      #  Rails.logger.debug("It is false")
      #  value = false
      #else
      #  value = true
      #end
      update_attribute(n_label_string, hash[n_label_string])
    end
    
    positive_training_data = Hash.new()
    positive_training_data["event_1"]  = []
    positive_training_data["event_2"]  = []
    positive_training_data["event_3"]  = []
    positive_training_data["event_4"]  = []
    positive_training_data["event_5"]  = []
    positive_training_data["event_6"]  = []
    positive_training_data["event_7"]  = []
    positive_training_data["event_8"]  = []

    negative_training_data = Hash.new()
    negative_training_data["event_1"]  = []
    negative_training_data["event_2"]  = []
    negative_training_data["event_3"]  = []
    negative_training_data["event_4"]  = []
    negative_training_data["event_5"]  = []
    negative_training_data["event_6"]  = []
    negative_training_data["event_7"]  = []
    negative_training_data["event_8"]  = []
    
    if hash["score_1_label"]== "true"
     
      positive_training_data["event_1"].push(hash[:score_1_event_1])
      positive_training_data["event_2"].push(hash[:score_1_event_2])
      positive_training_data["event_3"].push(hash[:score_1_event_3])
      positive_training_data["event_4"].push(hash[:score_1_event_4])
      positive_training_data["event_5"].push(hash[:score_1_event_5])
      positive_training_data["event_6"].push(hash[:score_1_event_6])
      positive_training_data["event_7"].push(hash[:score_1_event_7])
      positive_training_data["event_8"].push(hash[:score_1_event_8])
  
    else
      negative_training_data["event_1"].push(hash[:score_1_event_1])
      negative_training_data["event_2"].push(hash[:score_1_event_2])
      negative_training_data["event_3"].push(hash[:score_1_event_3])
      negative_training_data["event_4"].push(hash[:score_1_event_4])
      negative_training_data["event_5"].push(hash[:score_1_event_5])
      negative_training_data["event_6"].push(hash[:score_1_event_6])
      negative_training_data["event_7"].push(hash[:score_1_event_7])
      negative_training_data["event_8"].push(hash[:score_1_event_8])

    end

    if hash["score_2_label"] == "true" 
      positive_training_data["event_1"].push(hash[:score_2_event_1])
      positive_training_data["event_2"].push(hash[:score_2_event_2])
      positive_training_data["event_3"].push(hash[:score_2_event_3])
      positive_training_data["event_4"].push(hash[:score_2_event_4])
      positive_training_data["event_5"].push(hash[:score_2_event_5])
      positive_training_data["event_6"].push(hash[:score_2_event_6])
      positive_training_data["event_7"].push(hash[:score_2_event_7])
      positive_training_data["event_8"].push(hash[:score_2_event_8])

    else
      negative_training_data["event_1"].push(hash[:score_2_event_1])
      negative_training_data["event_2"].push(hash[:score_2_event_2])
      negative_training_data["event_3"].push(hash[:score_2_event_3])
      negative_training_data["event_4"].push(hash[:score_2_event_4])
      negative_training_data["event_5"].push(hash[:score_2_event_5])
      negative_training_data["event_6"].push(hash[:score_2_event_6])
      negative_training_data["event_7"].push(hash[:score_2_event_7])
      negative_training_data["event_8"].push(hash[:score_2_event_8])
    end

    if hash["score_3_label"] == "true"
      positive_training_data["event_1"].push(hash[:score_3_event_1])
      positive_training_data["event_2"].push(hash[:score_3_event_2])
      positive_training_data["event_3"].push(hash[:score_3_event_3])
      positive_training_data["event_4"].push(hash[:score_3_event_4])
      positive_training_data["event_5"].push(hash[:score_3_event_5])
      positive_training_data["event_6"].push(hash[:score_3_event_6])
      positive_training_data["event_7"].push(hash[:score_3_event_7])
      positive_training_data["event_8"].push(hash[:score_3_event_8])
    else
      negative_training_data["event_1"].push(hash[:score_3_event_1])
      negative_training_data["event_2"].push(hash[:score_3_event_2])
      negative_training_data["event_3"].push(hash[:score_3_event_3])
      negative_training_data["event_4"].push(hash[:score_3_event_4])
      negative_training_data["event_5"].push(hash[:score_3_event_5])
      negative_training_data["event_6"].push(hash[:score_3_event_6])
      negative_training_data["event_7"].push(hash[:score_3_event_7])
      negative_training_data["event_8"].push(hash[:score_3_event_8])
    end

    if hash["score_4_label"] == "true"
      positive_training_data["event_1"].push(hash[:score_4_event_1])
      positive_training_data["event_2"].push(hash[:score_4_event_2])
      positive_training_data["event_3"].push(hash[:score_4_event_3])
      positive_training_data["event_4"].push(hash[:score_4_event_4])
      positive_training_data["event_5"].push(hash[:score_4_event_5])
      positive_training_data["event_6"].push(hash[:score_4_event_6])
      positive_training_data["event_7"].push(hash[:score_4_event_7])
      positive_training_data["event_8"].push(hash[:score_4_event_8])
    else
      negative_training_data["event_1"].push(hash[:score_4_event_1])
      negative_training_data["event_2"].push(hash[:score_4_event_2])
      negative_training_data["event_3"].push(hash[:score_4_event_3])
      negative_training_data["event_4"].push(hash[:score_4_event_4])
      negative_training_data["event_5"].push(hash[:score_4_event_5])
      negative_training_data["event_6"].push(hash[:score_4_event_6])
      negative_training_data["event_7"].push(hash[:score_4_event_7])
      negative_training_data["event_8"].push(hash[:score_4_event_8])

    end

    if hash["score_5_label"] == "true"
      positive_training_data["event_1"].push(hash[:score_5_event_1])
      positive_training_data["event_2"].push(hash[:score_5_event_2])
      positive_training_data["event_3"].push(hash[:score_5_event_3])
      positive_training_data["event_4"].push(hash[:score_5_event_4])
      positive_training_data["event_5"].push(hash[:score_5_event_5])
      positive_training_data["event_6"].push(hash[:score_5_event_6])
      positive_training_data["event_7"].push(hash[:score_5_event_7])
      positive_training_data["event_8"].push(hash[:score_5_event_8])
    else
      negative_training_data["event_1"].push(hash[:score_5_event_1])
      negative_training_data["event_2"].push(hash[:score_5_event_2])
      negative_training_data["event_3"].push(hash[:score_5_event_3])
      negative_training_data["event_4"].push(hash[:score_5_event_4])
      negative_training_data["event_5"].push(hash[:score_5_event_5])
      negative_training_data["event_6"].push(hash[:score_5_event_6])
      negative_training_data["event_7"].push(hash[:score_5_event_7])
      negative_training_data["event_8"].push(hash[:score_5_event_8])

    end

    if hash["score_6_label"] == "true"
      positive_training_data["event_1"].push(hash[:score_6_event_1])
      positive_training_data["event_2"].push(hash[:score_6_event_2])
      positive_training_data["event_3"].push(hash[:score_6_event_3])
      positive_training_data["event_4"].push(hash[:score_6_event_4])
      positive_training_data["event_5"].push(hash[:score_6_event_5])
      positive_training_data["event_6"].push(hash[:score_6_event_6])
      positive_training_data["event_7"].push(hash[:score_6_event_7])
      positive_training_data["event_8"].push(hash[:score_6_event_8])
    else
      negative_training_data["event_1"].push(hash[:score_6_event_1])
      negative_training_data["event_2"].push(hash[:score_6_event_2])
      negative_training_data["event_3"].push(hash[:score_6_event_3])
      negative_training_data["event_4"].push(hash[:score_6_event_4])
      negative_training_data["event_5"].push(hash[:score_6_event_5])
      negative_training_data["event_6"].push(hash[:score_6_event_6])
      negative_training_data["event_7"].push(hash[:score_6_event_7])
      negative_training_data["event_8"].push(hash[:score_6_event_8])
    end

    if hash["score_7_label"] == "true"
      positive_training_data["event_1"].push(hash[:score_7_event_1])
      positive_training_data["event_2"].push(hash[:score_7_event_2])
      positive_training_data["event_3"].push(hash[:score_7_event_3])
      positive_training_data["event_4"].push(hash[:score_7_event_4])
      positive_training_data["event_5"].push(hash[:score_7_event_5])
      positive_training_data["event_6"].push(hash[:score_7_event_6])
      positive_training_data["event_7"].push(hash[:score_7_event_7])
      positive_training_data["event_8"].push(hash[:score_7_event_8])
    else
      negative_training_data["event_1"].push(hash[:score_7_event_1])
      negative_training_data["event_2"].push(hash[:score_7_event_2])
      negative_training_data["event_3"].push(hash[:score_7_event_3])
      negative_training_data["event_4"].push(hash[:score_7_event_4])
      negative_training_data["event_5"].push(hash[:score_7_event_5])
      negative_training_data["event_6"].push(hash[:score_7_event_6])
      negative_training_data["event_7"].push(hash[:score_7_event_7])
      negative_training_data["event_8"].push(hash[:score_7_event_8])

    end

    if hash["score_8_label"] == "true"
      positive_training_data["event_1"].push(hash[:score_8_event_1])
      positive_training_data["event_2"].push(hash[:score_8_event_2])
      positive_training_data["event_3"].push(hash[:score_8_event_3])
      positive_training_data["event_4"].push(hash[:score_8_event_4])
      positive_training_data["event_5"].push(hash[:score_8_event_5])
      positive_training_data["event_6"].push(hash[:score_8_event_6])
      positive_training_data["event_7"].push(hash[:score_8_event_7])
      positive_training_data["event_8"].push(hash[:score_8_event_8])
    else
      negative_training_data["event_1"].push(hash[:score_8_event_1])
      negative_training_data["event_2"].push(hash[:score_8_event_2])
      negative_training_data["event_3"].push(hash[:score_8_event_3])
      negative_training_data["event_4"].push(hash[:score_8_event_4])
      negative_training_data["event_5"].push(hash[:score_8_event_5])
      negative_training_data["event_6"].push(hash[:score_8_event_6])
      negative_training_data["event_7"].push(hash[:score_8_event_7])
      negative_training_data["event_8"].push(hash[:score_8_event_8])
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