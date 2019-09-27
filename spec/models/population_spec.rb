require 'rails_helper'

RSpec.describe Population, type: :model do

  it "should accept a year we know and return the correct population" do
    expect(Population.get(1900)).to eq(76212168)
    expect(Population.get(1990)).to eq(248709873)
  end

  it "should accept a year we don't know and return result based on linear progression" do
    expect(Population.get(1902)).to eq(79415432)
    expect(Population.get(1908)).to eq(89025224)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(1800)).to eq(0)
    expect(Population.get(0)).to eq(0)
    expect(Population.get(-1000)).to eq(0)
  end

  it "should accept a year that is after latest known and return result based on exponential growth" do
    expect(Population.get(1991)).to eq(271093761)
    expect(Population.get(1993)).to eq(322086498)
  end

  it "should accept a year that is after latest known and reutnr result based on logistic growth by passing second argument" do
    expect(Population.get(1991, :logistic)).to eq(263670969)
    expect(Population.get(1993, :logistic)).to eq(294829102)
    expect(Population.get(2300, :logistic)).to eq(749999999)
  end

  it "should accept a year that is after 2500 and return the result for 2500" do
    expect(Population.get(200000)).to eq(Population.get(2500))
  end

end
