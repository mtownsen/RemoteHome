class EmployeesController < ApplicationController
  # before_action :set_user, only: [:show]

  def index
    @users = current_user.company.users
  end

  def new
    @employee = User.new
  end

  def create
    @employee = User.new(user_params)
    @employee.company = current_user.company

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_path, notice: 'User was successfully added.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email).merge(password: Devise.friendly_token.first(8))
    end
end
