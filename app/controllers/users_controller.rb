class UsersController < ApplicationController
  # before_action :set_user, only: [:show]

  def index
    @users = current_user.company.users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.company = current_user.company

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'USer was successfully added.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
