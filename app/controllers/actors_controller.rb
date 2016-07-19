class ActorsController < ApplicationController
  
  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      redirect_to movies_path, notice: "Actor #{@actor.full_name} has been added!"
    else
      render :new
    end
  end

  protected

  def actor_params
    params.require(:actor).permit(:firstname, :lastname, :role)
  end

end
