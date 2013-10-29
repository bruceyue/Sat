class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?

  def seach_months_article
    @articles = Article.order('created_at DESC').limit(1000)
    @article_month = @articles.group_by { |a| a.created_at.beginning_of_month }
    if @article_month && @article_month.sort.reverse.first
      @end_month ||= @article_month.sort.reverse.first.first
    end
  end
  
  def admin?
    user = User.where(email: 'bruce.yue@outlook.com').first
    return user != nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    return true if current_user
  end

  # filter for pages that may only be visited by users logged in.
  def require_user
    if !current_user
      respond_to do |format|
        format.html { authenticate_user!}
        format.all { head(:unauthorized) }
      end
    else
      setup_api_client
    end
  end

  def redirect_to_target_or_default(default, *options)
    redirect_to(session[:return_to] || default, *options)
    session[:return_to] = nil
  end

  def store_target_location
    session[:return_to] = request.url
  end

  def setup_api_client
    @client = Databasedotcom::Client.new({})
    @client.version = '27.0'
    @client.authenticate :token => current_user.access_token,
                         :refresh_token => current_user.refresh_token,
                         :instance_url => current_user.instance_url
  end
end
