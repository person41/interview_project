require 'rails_helper'

RSpec.describe PopulationsController, type: :controller do
  render_views

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { year: "1900" }
      expect(response).to have_http_status(:success)
    end

    it "returns a population for a date" do
      year = 1900
      get :show, params: { year: year }
      expect(response.content_type).to eq "text/html"
      expect(response.body).to match /Population: #{Population.get(year)}/im
    end

    it "returns a population for a date when invoked as xhr" do
      year = 1900
      get :show, params: { year: year }, xhr: true
      expect(response.content_type).to eq "text/javascript"
      expect(response.body).to match /Population: #{Population.get(year)}/im
    end

    it "prevents rendering script tags" do
      year = "<script>alert('XSS')</script>"
      get :show, params: { year: year }
      expect(response.body).not_to match /for: <script>alert/im
    end
  end
end
