class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :edit, :update, :destroy ]

  def index
    @games = Game.all.order(date: :asc, time: :asc)
  end

  def show
  end

  def new
    @game = Game.new
    @teams = Team.all
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: "Game was successfully created."
    else
      @teams = Team.all
      render :new, status: 422 # change from :unprocessable_entity
    end
  end

  def edit
    @teams = Team.all
  end

  def update
    if @game.update(game_params)
      redirect_to @game, notice: "Game was successfully updated."
    else
      @teams = Team.all
      render :edit, status: 422 # change from :unprocessable_entity
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path, notice: "Game was successfully deleted."
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:date, :time, :location, :home_team_id, :away_team_id)
  end
end
