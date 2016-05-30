require 'rails_helper'

RSpec.describe HotelsController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      allow(Hotel).to receive(:all).and_return([Hotel.new])
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      allow(Hotel).to receive(:all).and_return([Hotel.new])
      get :index
      expect(response).to render_template("index")
    end

    it "renders the new form" do
      #allow(Hotel).to receive(:all).and_return([Hotel.new])
      get :new
      expect(response).to render_template("new")
    end

    it "search_api responds json" do
      allow(Hotel).to receive(:all).and_return([Hotel.new])
      request.accept = "application/json"
      get :search_api, format: :json
      expect(response.content_type).to eq "application/json"
    end

    it "search_api responds json" do
      allow(Hotel).to receive(:all).and_return([Hotel.new({:id => 7})])
      request.accept = "application/json"
      get :search_api, format: :json
      expect(response.body[0]).to render_template("hotels/search_api")
    end

  end
end
