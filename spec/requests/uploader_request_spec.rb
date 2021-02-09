require 'rails_helper'

RSpec.describe "Uploaders", type: :request do

  describe "GET /Thumbnail" do
    it "returns http success" do
      get "/uploader/Thumbnail"
      expect(response).to have_http_status(:success)
    end
  end

end
