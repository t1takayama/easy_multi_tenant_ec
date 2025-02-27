class Admin::SessionsController < Admin::BaseController
  def new
  end

  def create
    admin_user = Admin::User.find_by(email: session_params[:email])

    if admin_user&.authenticate(session_params[:password])
      session[:admin_user_id] = admin_user.id
      redirect_to admin_tenants_path, notice: 'Successfully signed in.'
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
