require "test_helper"

class RsvpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = Team.create!(name: "Test Team")
    @player = Player.create!(
      name: "Test Player",
      email: "test@example.com",
      phone: "15551234567",
      team: @team
    )
    @game = @team.games.create!(
      date: Date.tomorrow,
      time: Time.now,
      location: "Test Stadium",
      opponent: "Rival Team",
      home_away: "home"
    )
    @rsvp = Rsvp.create!(
      game: @game,
      player: @player,
      status: "pending"
    )
  end

  test "should update rsvp status" do
    patch rsvp_url(@rsvp), params: { status: "yes" }
    assert_redirected_to team_game_url(@team, @game)

    @rsvp.reload
    assert_equal "yes", @rsvp.status
  end
end
