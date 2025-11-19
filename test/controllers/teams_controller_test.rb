require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = Team.create!(name: "Test Team")
  end

  test "should get index" do
    get teams_url
    assert_response :success
  end

  test "should get show" do
    get team_url(@team)
    assert_response :success
  end
end
