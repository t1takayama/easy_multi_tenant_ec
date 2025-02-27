class Customer::RegistrationsController < Customer::BaseController
  before_action :set_tenant_id

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to sign_in_path, notice: 'Your sign up was successful.'
    else
      render :new
    end
  end

  def edit
  end

  private

  def customer_params
    params.expect(customer: [:name, :email, :password, :password_confirmation, :tenant_id])
  end
end
