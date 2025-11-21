require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = true

  def setup
    # Ensure clean slate
    Game.destroy_all
    Team.destroy_all
    Player.destroy_all
    Rsvp.destroy_all

    @team = Team.create!(name: "Test Team")
    @game = @team.games.create!(
      date: Date.tomorrow,
      time: Time.now,
      location: "Test Stadium",
      opponent: "Rival Team",
      home_away: "home"
    )
  end

  test "should get new" do
    get new_team_game_url(@team)
    assert_response :success
  end

  test "should create game" do
    assert_difference("Game.count") do
      post team_games_url(@team), params: {
        game: {
          date: Date.tomorrow + 1,
          time: Time.now,
          location: "Test Location",
          opponent: "Another Team",
          home_away: "away"
        }
      }
    end

    assert_redirected_to team_url(@team)
  end

  test "should show game" do
    get team_game_url(@team, @game)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_game_url(@team, @game)
    assert_response :success
  end

  test "should update game" do
    patch team_game_url(@team, @game), params: {
      game: {
        location: "Updated Location"
      }
    }
    assert_redirected_to team_url(@team)
  end

  test "should destroy game" do
    assert_difference("Game.count", -1) do
      delete team_game_url(@team, @game)
    end

    assert_redirected_to team_url(@team)
  end
end



#  test "should get index" do
#    get games_index_url
#    assert_response :success
#  end
#
#  test "should get show" do
#    get games_show_url
#    assert_response :success
#  end
#
#  test "should get new" do
#    get games_new_url
#    assert_response :success
#  end
#
#  test "should get create" do
#    get games_create_url
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get games_edit_url
#    assert_response :success
#  end
#
#  test "should get update" do
#    get games_update_url
#    assert_response :success
#  end
#
#  test "should get destroy" do
#    get games_destroy_url
#    assert_response :success
#  end
# end
