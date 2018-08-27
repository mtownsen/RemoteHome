class EmployeesController < ApplicationController
  # before_action :set_user, only: [:show]

  def index
    @users = current_user.company.users
  end

  def new
    @employee = User.new
    @groups = current_user.company.groups
  end

  def create
    @employee = User.new(user_params)
    @employee.company = current_user.company
    add_groups

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

    def add_groups
      params[:user][:groups].each do |group_id|
        if group_id != ''
          @employee.groups << Group.find_by_id(group_id)
        end
      end
    end
end
