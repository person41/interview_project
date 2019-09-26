class LogRecordsController < ApplicationController
  def index
    @log_records = LogRecord.all
    @requests_by_year = Population
                          .select("populations.year, COUNT(log_records.year) AS request_count")
                          .joins("LEFT JOIN log_records ON log_records.year = populations.year AND log_records.exact = TRUE")
                          .group("populations.year")
                          .order("request_count DESC")

  end
end
