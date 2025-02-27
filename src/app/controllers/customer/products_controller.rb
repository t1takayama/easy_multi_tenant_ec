class Customer::ProductsController < Customer::BaseController
  def index
    @products = Product.where(tenant_id: @tenant.id)
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
end
