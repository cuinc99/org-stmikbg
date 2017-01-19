class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation, :slug, :avatar, :jenis)
  end

  def account_update_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation, :current_password, :slug, :avatar, :jenis)
  end
end
