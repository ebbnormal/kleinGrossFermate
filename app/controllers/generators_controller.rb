class GeneratorsController < ApplicationController

  def index
    @generators = Generator.all.sort_by(&:created_at)
  end

  def create
    @generator = Generator.new()
    @generator.calculate_model(params[:generator])
 
    if @generator.save
      redirect_to @generator
    else
      @generator.errors.full_messages.each do |msg|
        flash[:error] = msg
      end
      redirect_to action: "new"  
    end
  end

  def show
    @generator = Generator.find(params[:id])
  end

  def new
    prng = Random.new(Time.now.to_i)
    @score_1_event_1 = prng.rand(3)+1
    @score_1_event_2 = prng.rand(3)+1
    @score_1_event_3 = prng.rand(3)+1
    @score_1_event_4 = prng.rand(3)+1
    @score_1_event_5 = prng.rand(3)+1
    @score_1_event_6 = prng.rand(3)+1
    @score_1_event_7 = prng.rand(3)+1
    @score_1_event_8 = prng.rand(3)+1

    @score_2_event_1 = prng.rand(3)+1
    @score_2_event_2 = prng.rand(3)+1
    @score_2_event_3 = prng.rand(3)+1
    @score_2_event_4 = prng.rand(3)+1
    @score_2_event_5 = prng.rand(3)+1
    @score_2_event_6 = prng.rand(3)+1
    @score_2_event_7 = prng.rand(3)+1
    @score_2_event_8 = prng.rand(3)+1

    @score_3_event_1 = prng.rand(3)+1
    @score_3_event_2 = prng.rand(3)+1
    @score_3_event_3 = prng.rand(3)+1
    @score_3_event_4 = prng.rand(3)+1
    @score_3_event_5 = prng.rand(3)+1
    @score_3_event_6 = prng.rand(3)+1
    @score_3_event_7 = prng.rand(3)+1
    @score_3_event_8 = prng.rand(3)+1

    @score_4_event_1 = prng.rand(3)+1
    @score_4_event_2 = prng.rand(3)+1
    @score_4_event_3 = prng.rand(3)+1
    @score_4_event_4 = prng.rand(3)+1
    @score_4_event_5 = prng.rand(3)+1
    @score_4_event_6 = prng.rand(3)+1
    @score_4_event_7 = prng.rand(3)+1
    @score_4_event_8 = prng.rand(3)+1

    @score_5_event_1 = prng.rand(3)+1
    @score_5_event_2 = prng.rand(3)+1
    @score_5_event_3 = prng.rand(3)+1
    @score_5_event_4 = prng.rand(3)+1
    @score_5_event_5 = prng.rand(3)+1
    @score_5_event_6 = prng.rand(3)+1
    @score_5_event_7 = prng.rand(3)+1
    @score_5_event_8 = prng.rand(3)+1

    @score_6_event_1 = prng.rand(3)+1
    @score_6_event_2 = prng.rand(3)+1
    @score_6_event_3 = prng.rand(3)+1
    @score_6_event_4 = prng.rand(3)+1
    @score_6_event_5 = prng.rand(3)+1
    @score_6_event_6 = prng.rand(3)+1
    @score_6_event_7 = prng.rand(3)+1
    @score_6_event_8 = prng.rand(3)+1

    @score_7_event_1 = prng.rand(3)+1
    @score_7_event_2 = prng.rand(3)+1
    @score_7_event_3 = prng.rand(3)+1
    @score_7_event_4 = prng.rand(3)+1
    @score_7_event_5 = prng.rand(3)+1
    @score_7_event_6 = prng.rand(3)+1
    @score_7_event_7 = prng.rand(3)+1
    @score_7_event_8 = prng.rand(3)+1
 
    @score_8_event_1 = prng.rand(3)+1
    @score_8_event_2 = prng.rand(3)+1
    @score_8_event_3 = prng.rand(3)+1
    @score_8_event_4 = prng.rand(3)+1
    @score_8_event_5 = prng.rand(3)+1
    @score_8_event_6 = prng.rand(3)+1
    @score_8_event_7 = prng.rand(3)+1
    @score_8_event_8 = prng.rand(3)+1
  end
end