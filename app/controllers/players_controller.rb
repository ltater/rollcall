class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]

  def index
    @players = Player.all
  end

  def show
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to @player
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to @player
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path
  end

  private
    def set_player
      @player = Player.find(params[:id])
  end

  def player_params
    params.expect(player: [ :name, :phone, :email ])
  end

  def send_notification
    player = Player.find(params[:id])

    twilio = TwilioService.new
    result = twilio.send_sms(
      to: player.phone,
      body: "Hello #{player.name}, this is a Roll Call message."
    )

    if result
      flash[:notice] = "Message sent successfully!"
    else
      flash[:alert] = "Failed to send message."
    end

    redirect_to players_path
  end
end
