require 'sinatra'
require 'sinatra/json'


get '/api/resource' do
  if params["access_token"].eql?("valid_token_for_tests") 
    json res = {
      key: "response key",
      value: "responce value",
      nested_field: {
        name: "nested field name",
        why: "just for kicks!"
      }
    }
  else
    json res = {
      error: "unauthorized"
    }
  end
end

