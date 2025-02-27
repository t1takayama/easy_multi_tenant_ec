class Customer::AddressesController < Customer::BaseController
  before_action :customer_sign_in_required

  def index
    @address = Address.all
  end

  def new
    redirect_to addresses_path unless current_customer.address.nil?
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to addresses_path, notice: 'Address was successfully created.'
    else
      render :new
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer, notice: 'Address was successfully deleted.'
  end

  private

  def address_params
    params.expect(address: [:customer_id, :name, :postal_code, :prefecture, :address])
  end
end
