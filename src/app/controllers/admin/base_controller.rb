class Admin::BaseController < ApplicationController
  private

  def admin_user_login_required
    redirect_to admin_sign_in_path unless admin_user_signed_in?
  end
end
