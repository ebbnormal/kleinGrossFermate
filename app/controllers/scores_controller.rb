class ScoresController < ApplicationController

  def new
    @generator = Generator.find(params[:generator_id])
    @score_generated = @generator.generate_score
    @score = Score.new
  end

  def create
  	@generator = Generator.find(params[:generator_id])
    @score = @generator.scores.build(score_params)
    if @score.save
       redirect_to generator_score_path(id: @score.id)
    else
       redirect_to action: "new"
    end
  end

  def show
  	@score = Score.find(params[:id])
  	Rails.logger.debug(@score.event4)
  end

  def score_params
    params.require(:score).permit(:event1, :event2, :event3, :event4, :event5, :event6, :event7, :event8)
  end

  def index
  	@generator = Generator.find(params[:generator_id])
  	@scores = @generator.scores.all
  	Rails.logger.debug(@scores.length)

  end

end
