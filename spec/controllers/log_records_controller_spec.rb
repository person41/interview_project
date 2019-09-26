require 'rails_helper'

RSpec.describe LogRecordsController, type: :controller do

  let(:valid_attributes) {
    { ip: "127.0.0.1", year: Date.new(1990), population: 2 }
  }

  describe "GET #index" do
    it "returns a success response" do
      LogRecord.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

end
