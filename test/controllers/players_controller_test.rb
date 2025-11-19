require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = Team.create!(name: "Test Team")
    @player = Player.create!(
      name: "Test Player",
      email: "test@example.com",
      phone: "+15551234567",
      team: @team
    )
  end

  test "should get index" do
    get players_index_url
    # get players_path
    assert_response :success
  end
end
