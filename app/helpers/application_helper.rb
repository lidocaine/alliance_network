module ApplicationHelper
  
  def title
    app_name = "The Alliance Network"
    if @title.nil?
      app_name
    else
      "#{app_name} | #{@title}"
    end
  end
  
end
