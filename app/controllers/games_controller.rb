class GamesController < ApplicationController
  before_action :set_team
  before_action :set_game, only: [ :show, :edit, :update, :destroy, :send_roll_call ]

  def index
    @games = Game.all.order(date: :asc, time: :asc)
  end

  def show
  end

  def new
    @game = @team.games.new
  end

  def create
    @game = @team.games.new(game_params)

    if @game.save
      redirect_to team_path(@team), notice: "Game was successfully created."
    else
      render :new, status: 422 # change from :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to team_path(@team), notice: "Game was successfully updated."
    else
      render :edit, status: 422 # change from :unprocessable_entity
    end
  end

  def destroy
    @game.destroy
    redirect_to team_path(@team), notice: "Game was successfully deleted."
  end

  def initialize_rsvps
    @game.create_rsvps_for_players
    redirect_to @game, notice: "Roll call initialized for all players!"
  end

  def send_roll_call
    @game.create_rsvps_for_team
    redirect_to [@team, @game], notice: "Roll call sent to all team players!"
  end

  private
  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_game
    @game = @team.games.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:date, :time, :location, :opponent, :home_away)
  end
end
