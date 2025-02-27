class Admin::OwnersController < Admin::BaseController
  before_action :admin_user_login_required
  before_action :set_tenant_id

  def index
    @owners = Owner.where(tenant_id: @tenant_id)
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)

    if @owner.save
      redirect_to admin_tenant_owner_path(@tenant_id, @owner), notice: 'Owner was successfully created.'
    else
      render :new
    end
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])

    if @owner.update(owner_params)
      redirect_to admin_tenant_owner_path(@tenant_id, @owner.id), notice: "Owner was successfully updated."
    else
      render :edit
    end
  end

  private

  def owner_params
    params.expect(owner: [:email, :password, :password_confirmation, :tenant_id])
  end

  def set_tenant_id
    @tenant_id = params[:tenant_id]    
  end
end
