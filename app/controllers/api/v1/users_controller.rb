class Api::V1::UsersController < Api::V1::BaseController

  api :PUT, "/v1/users", "Update an user"
  param :phone, String
  param :address, String
  def update
    current_user.update(user_update_params)
    head :ok
  end

  protected

  def user_update_params
    # params.permit(:first_name, :last_name, :email, :uid, :uid_type, :avatar)
    params.permit(:phone, :address).reject{|_, v| v.blank?}
  end
end
