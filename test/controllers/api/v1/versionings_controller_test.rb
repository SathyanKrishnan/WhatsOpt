require 'test_helper'

class Api::V1::VersioningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user1 = users(:user1)
    @auth_headers = {"Authorization" => "Token " + TEST_API_KEY}
  end
  
  test "should get version information" do
    get api_v1_versioning_url, as: :json, headers: @auth_headers
    assert_response :success
    resp = JSON.parse(response.body)
    assert_match /^\d+\.\d+\.\d+$/, resp['whatsopt']
    assert_match /^\d+\.\d+\.\d+$/, resp['wop']
  end
  
end
