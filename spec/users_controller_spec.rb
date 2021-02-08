require 'spec_helper'
  
  describe UsersController do
    it "allows a user to login if they are not currently logged in" do
      get '/login'
      expect(last_response.status).to eq(200)
    end
  end