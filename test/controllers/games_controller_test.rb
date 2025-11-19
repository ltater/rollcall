require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @team1 = teams(:one) # removed :one and added :sampleteam1 / fixture teams, games
    # @team2 = teams(:two) # removed :two and added :sampleteam2 / fixture teams, games
    # @game = games(:one) # removed :one and added :game1 / fixture games
    @team1 = Team.create!(name: "Team Alpha")
    @team2 = Team.create!(name: "Team Beta")
    @game = Game.create!(
      date: Date.tomorrow,
      time: Time.now,
      location: "Test Stadium",
      home_team: @team1,
      away_team: @team2
      )
  end

  # Debug: make sure games exists
  # assert_not_nil @game, "Game fixture should not be nil"
  # assert_not_nil @game.home_team, "Home team should not be nil"
  # assert_not_nil @game.away_team, "Away team should not be nil"

  test "should get index" do
    get games_url
    assert_response :success
  end

  test "should get new" do
    get new_game_url
    assert_response :success
  end

  test "should create game" do
    assert_difference("Game.count") do
      post games_url, params: {
        game: {
          date: Date.tomorrow,
          time: Time.now,
          location: "Test Location",
          home_team_id: @team1.id,
          away_team_id: @team2.id
        }
      }
    end

    assert_redirected_to game_url(Game.last)
  end

  test "should show game" do
    get game_url(@game)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_url(@game)
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: {
      game: {
        location: "Updated Location" # Changed from Updated Location (or put 1)
      }
    }
    assert_redirected_to game_url(@game)
  end

  test "should destroy game" do
    assert_difference("Game.count", -1) do
      delete game_url(@game)
    end

    assert_redirected_to games_url
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
