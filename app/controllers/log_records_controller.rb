class LogRecordsController < ApplicationController
  def index
    @log_records = LogRecord.all
  end
end
