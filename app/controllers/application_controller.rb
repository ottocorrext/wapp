class ApplicationController < ActionController::Base
  def build_date_from_select(hash)
    begin
      return DateTime.new hash[:year].to_i, hash[:month].to_i, hash[:day].to_i
    rescue StandardError => e
      logger.error("Failed to parse date: #{e.message}")
      logger.error(e.backtrace)
    end

    nil
  end
end
