class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update]

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    if current_user.admin?
      @attraction = Attraction.create(attraction_params)
    end
    redirect_to attraction_path(@attraction)
  end

  def show
  end

  def edit
  end

  def update
    if current_user.admin?
      @attraction.update(attraction_params)
    end
    redirect_to attraction_path(@attraction)
  end

  private

    def attraction_params
      params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
    end

    def set_attraction
      @attraction = Attraction.find_by(id: params[:id])
    end

end
