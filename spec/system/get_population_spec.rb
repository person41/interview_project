require 'rails_helper'

RSpec.describe "Get population by year", type: :system do
  it "User is presented with an input form" do
    visit populations_path
    assert_selector "input[name=year]"
    assert_selector "button[type=submit]"
  end

  describe "When user enters a valid year" do
    it "shows a population figure" do
      visit populations_path
      fill_in 'year', with: "1990"

      find("button[type=submit]").click
      assert_text "You requested the population for: 1990"
    end

    it "does not show radio buttons for methods when year is 1990" do
      visit populations_path
      fill_in 'year', with: "1990"

      expect(page).not_to have_css "div#calculationMethodBoxes"
    end

    it "shows radio buttons for methods when year is > 1990" do
      visit populations_path
      fill_in 'year', with: "1991"

      assert_selector "div#calculationMethodBoxes"
    end
  end
end
