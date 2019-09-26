class Population < ApplicationRecord
  GROWTH_RATE_PER_YEAR = 1.09
  MAX_YEAR = 2500

  def self.min_year
    Population.minimum("year").year
  end

  def self.max_year
    Population.maximum("year").year
  end

  def self.get(year)
    year = year.to_i

    return 0 if year < min_year
    year = MAX_YEAR if year > MAX_YEAR

    return future_popoulation_exponential_growth(year, max_year) if year > max_year

    population_record = Population.find_by_year(Date.new(year))
    if population_record.present?
      population_record.population
    else
      population_using_linear_progression(year)
    end
  end

  private

  def self.future_popoulation_exponential_growth(year, base_year)
    base_year_record = Population.find_by_year(Date.new(base_year))
    (GROWTH_RATE_PER_YEAR ** (year - base_year) * base_year_record.population).to_i
  end

  def self.population_using_linear_progression(year)
    upper_population, upper_year = closest_upper_year_record(year)
    lower_population, lower_year = closest_lower_year_record(year)

    lower_population +
      (year - lower_year) *
      ((upper_population - lower_population) /
       (upper_year - lower_year))
  end

  def self.closest_upper_year_record(year)
    record = Population.where("year > ?", Date.new(year)).order(year: :asc).first
    [record.population, record.year.year]
  end

  def self.closest_lower_year_record(year)
    record = Population.where("year < ?", Date.new(year)).order(year: :desc).first
    [record.population, record.year.year]
  end
end
