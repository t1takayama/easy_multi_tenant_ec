class Owner::SessionsController < Owner::BaseController
  def new
  end

  def create
    owner = Owner.find_by(email: session_params[:email])

    if owner&.authenticate(session_params[:password])
      session[:owner_id] = owner.id
      redirect_to owner_products_path, notice: 'Successfully signed in.'
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
