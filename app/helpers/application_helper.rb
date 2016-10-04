module ApplicationHelper

  def format_date(datetime)
    datetime.strftime("%e-%_m-%Y - %H:%m")
  end
end
