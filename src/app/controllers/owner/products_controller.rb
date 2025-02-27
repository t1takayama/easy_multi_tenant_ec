class Owner::ProductsController < Owner::BaseController
  before_action :owner_login_required
  before_action :set_product, only: [:edit, :show]
  before_action :set_tenant

  def index
    @products = Product.where(tenant_id: @tenant.id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to owner_product_path(@product), notice: "Product was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to owner_product_path(@product), notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to request.referer, notice: "Product was successfully deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.expect(product: [:name, :description, :price, :stock, :tenant_id, :image])
  end
end
