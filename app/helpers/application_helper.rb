module ApplicationHelper
  def time_for_select(datetime)
    datetime ? Time.zone.parse(datetime.to_s) : Time.zone.now
  end

  def format_datetime(datetime)
    return '' unless datetime
    datetime.strftime('%m-%d-%Y %H:%M')
  end
end
