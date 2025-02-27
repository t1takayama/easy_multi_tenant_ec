class Owner::OrdersController < Owner::BaseController
  before_action :owner_login_required
  before_action :set_tenant

  def index
    @orders = Order.joins(:customer).where(customer: { tenant_id: @tenant.id })
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to owner_order_path(@order), notice: "Order was successfully updated."
    else
      render :edit
    end
  end

  private

  def order_params
    params.expect(order: [:status])
  end
end
