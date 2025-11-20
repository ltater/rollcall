class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :edit, :update, :destroy, :initialize_rsvps, :send_team_roll_call ]

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

  def initialize_rsvps
    @game.create_rsvps_for_players
    redirect_to @game, notice: "Roll call initialized for all players!"
  end

  def send_team_roll_call
    team = Team.find(params[:team_id])

    # Only create RSVPs for this specific team's players
    team.players.each do |player|
      @game.rsvps.find_or_create_by(player: player)
    end

    redirect_to team_path(team), notice: "Roll call sent to #{team.name} players!"
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:date, :time, :location, :home_team_id, :away_team_id)
  end
end
