class Admin::TenantsController < Admin::BaseController
  before_action :admin_user_login_required

  def index
    @tenants = Tenant.all
  end

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      redirect_to admin_tenant_path(@tenant), notice: "Tenant was successfully created."
    else
      render :new
    end
  end

  def show
    @tenant = Tenant.find(params[:id])
  end

  def edit
    @tenant = Tenant.find(params[:id])
  end

  def update
    @tenant = Tenant.find(params[:id])

    if @tenant.update(tenant_params)
      redirect_to admin_tenant_path(@tenant), notice: "Tenant was successfully updated."
    else
      render :edit
    end
  end

  private

  def tenant_params
    params.expect(tenant:[:name, :status, :domain])
  end
end
