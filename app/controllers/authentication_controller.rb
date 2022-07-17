class AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login, :register]

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, role: @user.role, exp: time.strftime("%m-%d-%Y %H:%M"),
                     email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  # POST /users
  def register
    @user = User.new(registeration_params)
    unless registeration_params[:referral_code].blank?
      referrer = User.find_by(referral_code: registeration_params[:referral_code])
      if referrer.nil?
        render json: { errors: ["wrong code"] }, status: :unprocessable_entity 
        return
      end
      @user.referrer = referrer
    end

    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     email: @user.email }, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def registeration_params
    params.permit(:email, :password, :password_confirmation, :referral_code)
  end
end