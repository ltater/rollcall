require "test_helper"

class RsvpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team1 = Team.create!(name: "Team Alpha")
    @team2 = Team.create!(name: "Team Beta")
    @player = Player.create!(
      name: "Test Player",
      email: "test@example.com",
      phone: "15551234567",
      team: @team1
    )
    @game = Game.create!(
      date: Date.tomorrow,
      time: Time.now,
      location: "Test Stadium",
      home_team: @team1,
      away_team: @team2
    )
    @rsvp = Rsvp.create!(
      game: @game,
      player: @player,
      status: "pending"
    )
  end

  test "should update rsvp status" do
    patch rsvp_url(@rsvp), params: { status: "yes" }
    assert_redirected_to game_url(@game)

    @rsvp.reload
    assert_equal "yes", @rsvp.status
  end
end
