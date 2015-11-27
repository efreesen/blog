class ErrorsController < Blog::BlogController
  caches_action :not_found,             expires_in: 24.hour
  caches_action :internal_server_error, expires_in: 24.hour

  def not_found
    render(:status => 404)
  end

  def internal_server_error
    render(:status => 500)
  end
end
