class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_filter :request_provider_confirmation, only: :show

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def request_provider_confirmation
    if @user.is_student? and not @user.provider_confirmation_sent?
      @user.generate_provider_confirmation_token
      @user.request_provider_confirmation
    end
  end

end
