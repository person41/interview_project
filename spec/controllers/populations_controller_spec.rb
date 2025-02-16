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

    it "calls population calculation method with exponential method" do
      year = 2005
      expect(Population).to receive(:get).with(year, :exponential)
      get :show, params: { year: year, calculation_method: "exponential" }, xhr: true
      expect(response).to have_http_status(:success)
    end

    it "calls population calculation method with logistic method" do
      year = 2005
      expect(Population).to receive(:get).with(year, :logistic)
      get :show, params: { year: year, calculation_method: "logistic" }, xhr: true
      expect(response).to have_http_status(:success)
    end

    it "creates record user's answer and query" do
      year = "1990"
      expect(LogRecord).to receive(:create).with(ip: "0.0.0.0",
                                                 year: Date.new(year.to_i),
                                                 population: 248709873,
                                                 exact: true).and_call_original

      expect { get(:show, params: { year: year }) }.to change { LogRecord.count }.by(1)
    end
  end
end
