class Population < ApplicationRecord

  def self.min_year
    Population.all.map(&:year).min.year
  end

  def self.max_year
    Population.maximum("year").year
  end

  def self.get(year)
    year = year.to_i

    return 0 if year < min_year
    year = max_year if year >= max_year

    pop = nil
    until pop
      pop = Population.find_by_year(Date.new(year))
      year = year - 1
    end

    return pop.population if pop

    nil
  end

end
