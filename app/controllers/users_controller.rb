class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_login, only: %i[edit update destroy]
  
  def check_login
    if !@user || session[:user_id] != @user.id
      redirect_to '/main', notice: "Please login"  
    end
  end
  
  def main
  end
  
  def login_form
    session[:user_id]=nil
  end
  
  def login
    @ema = params[:email]
    @pas = params[:pass]
    @user = User.find_by(email:@ema.to_s)
    #respond_to do |format|
    if (@user && @user.authenticate(@pas))
      session[:user_id] = @user.id
      redirect_to @user , notice: "welcome"
      #format.html {redirect_to @user, notice: "welcome"}
      #format.json {render :show, status: :create, location: @user}
    else
      redirect_to '/main', notice: "try again"
      #format.html {redirect_to '/main', notice: "try again"}
      #format.json {render json: @user.errors, status: :unprocessable_entity}
    end
    #end
  end
  
  def create_fast
    @user = User.create(name:params[:name], email:params[:email])
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edits
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    #respond_to do |format|
    #  format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
       params.require(:user).permit(:email, :name, :birthday, :address, :postal_code, :password)
    end
    
end
