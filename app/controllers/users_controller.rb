class UsersController < ApplicationController
  before_action :require_signin, only: [:show]
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def show
  end

  private

    def user_params
      params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :admin, :password)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def require_signin
      return redirect_to root_path unless current_user
    end

end
