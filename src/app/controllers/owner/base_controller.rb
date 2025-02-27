class Owner::BaseController  < ApplicationController 
  private

  def owner_login_required
    redirect_to owner_sign_in_path unless owner_signed_in?
  end

  def set_tenant
    @tenant = current_owner.tenant
  end
end
