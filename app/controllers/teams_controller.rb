class TeamsController < ApplicationController
  before_action :set_team, only: [ :show, :edit, :update, :destroy, :add_player, :remove_player ]

  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to @team
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path
  end

  def add_player
    player = Player.find(params[:player_id])

   if player.update(team: @team)
      redirect_to @team, notice: "#{player.name} added to team"
   else
      redirect_to @team, alert: "Could not add player to team"
   end
  end

  def remove_player
    player = Player.find(params[:player_id])
    if player.update(team_id: nil)
      redirect_to @team, notice: "#{player.name} removed from team!"
    else
      redirect_to @team, alert: "Could not remove player from team."
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.expect(team: [ :name ])
    end
end
