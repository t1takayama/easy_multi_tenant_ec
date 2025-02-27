class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :admin_user_signed_in?, :current_admin_user
  helper_method :owner_signed_in?, :current_owner
  helper_method :customer_signed_in?, :current_customer

  def admin_user_signed_in?
    !current_admin_user.nil?
  end

  def current_admin_user
    @current_admin_user ||= Admin::User.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end

  def owner_signed_in?
    !current_owner.nil?
  end

  def current_owner
    @current_owner ||= Owner.find_by(id: session[:owner_id]) if session[:owner_id]
  end

  def customer_signed_in?
    !current_customer.nil?
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id]) if session[:customer_id]
  end
end
