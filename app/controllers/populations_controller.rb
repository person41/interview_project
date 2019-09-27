class PopulationsController < ApplicationController
  after_action :log_query_answer_pair, only: :show

  def index
  end

  def show
    @year = params[:year].to_i
    @method = params[:calculation_method] == "exponential" ? :exponential : :logistic
    @population = Population.get(@year, @method)
  end

  private

  def log_query_answer_pair
    LogRecord.create(
      ip: request.ip,
      year: Date.new(@year),
      population: @population,
      exact: Population.find_by_year(Date.new(@year)).present?
    )
  end
end
