class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show]

  def index
    @employees = current_user.company.users
  end

  def show 
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
        format.html { redirect_to employees_path, notice: 'Employee was successfully added.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_employee
      @employee = current_user.company.users.find(params[:id])
    end

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
