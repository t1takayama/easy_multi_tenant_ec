class Customer::CartItemsController < Customer::BaseController
  before_action :customer_sign_in_required

  def index
    @cart_items = current_customer.cart_items
    @subtotal = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.total_price }
  end

  def create
    increase_or_create(params[:cart_item][:product_id])
    redirect_to cart_items_path, notice: 'Succuessfully added to your cart.'
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer, notice: 'Successfully deleted.'
  end

  private

  def increase_or_create(product_id)
    cart_item = current_customer.cart_items.find_by(product_id:)

    if cart_item
      cart_item.increment!(:quantity, 1)
    else
      current_customer.cart_items.build(product_id:).save
    end    
  end
end
