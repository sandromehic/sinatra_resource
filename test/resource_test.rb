require_relative '../lib/resource'
require 'minitest/autorun'
require 'rack/test'

class MyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_my_default
    get '/api/resource'
    assert_equal reply["error"], "unauthorized"
  end

  def test_resource_with_token
    get '/api/resource', {access_token: "valid_token_for_tests"}
    assert_equal "response key", reply["key"]
  end

  def test_resource_with_invalid_token
    get '/api/resource', {access_token: "invalid_token_for_tests"}
    assert_equal reply["error"], "unauthorized"
  end

  def reply
    JSON.parse(last_response.body)
  end

end
