class Customer::SessionsController < Customer::BaseController
  def new
  end

  def create
    customer = Customer.find_by(email: session_params[:email])

    if customer&.authenticate(session_params[:password])
      session[:customer_id] = customer.id
      redirect_to root_path, notice: 'Successfully signed in.'
    else
      flash.now[:alert] = 'Sign in failed.'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Successfully signed out.'
  end

  private

  def session_params
    params.expect(session: [:email, :password])
  end
end
