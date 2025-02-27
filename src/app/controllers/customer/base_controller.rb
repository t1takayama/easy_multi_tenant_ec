class Customer::BaseController < ApplicationController
  before_action :before_tenant_request

  private

  def customer_sign_in_required
    redirect_to sign_in_path unless customer_signed_in?
  end

  def set_tenant
    uri = URI.parse(request.base_url)
    domain = uri.host
    @tenant = Tenant.find_by(domain: domain)   
  end

  def tenant_available?
    set_tenant
    @tenant && @tenant.status == 'normal' ? true : false
  end

  def before_tenant_request  
    unless tenant_available?
      render plain: 'Tenant not found.', stauts: 404
    end
  end
end
