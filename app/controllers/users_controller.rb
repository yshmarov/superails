class UsersController < ApplicationController
  def index
    @q = User.order(created_at: :desc).ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true))
  end
  
  def show
    @user = User.friendly.find(params[:id])
  end
end