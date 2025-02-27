class Customer::OrdersController < Customer::BaseController
  before_action :customer_sign_in_required

  def index
    @orders = Order.all
  end

  def new
    redirect_to root_path if current_customer.cart_items.empty?

    @order = Order.new
    @postage = postage
    @subtotal = current_customer.cart_items.inject(0) { |sum, cart_item| sum + cart_item.total_price }
    @billing_amuont = @subtotal + @postage
  end

  def create
    ApplicationRecord.transaction do
      order = Order.create!(order_params)
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.create!({
          order_id: order.id,
          product_id: cart_item.product.id,
          price: cart_item.product.price,
          quantity: cart_item.quantity
        })
        purchased_product = Product.find(cart_item.product.id)
        purchased_product.update!(stock: (purchased_product.stock - cart_item.quantity))
      end
    end

    unless current_customer.cart_items.destroy_all
      logger.error "[customer id: #{current_customer.id}] cart_items.destroy_all failed"
    end
   
    redirect_to success_orders_path
  rescue ActiveRecord::RecordInvalid => e
    logger.error e.record.errors
    redirect_to error_orders_path
  rescue ActiveRecord::RecordNotFound => e
    logger.error e.record.errors
    redirect_to error_orders_path
  end

  def show
    @order = Order.find(params[:id])
  end

  def error
  end

  def success
  end


  private

  def postage
    500
  end

  def order_params
    params.expect(order: [:name, :postal_code, :prefecture, :address, :postage, :billing_amount, :status, :payment_method, :customer_id])
  end
end
