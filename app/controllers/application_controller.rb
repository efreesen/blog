class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :title

  def title(title)
    string = "Efreesen's Blog"

    if title != "Efreesen&#39;s Blog"
      string += " - #{title}"
    end

    string
  end

  def resource_not_found
    redirect_to '/404.html'
  end
end
