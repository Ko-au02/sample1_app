class UsersController < ApplicationController

  def index
    @user = User.find_by(id: params[:id])
  end

  def new

  end

  def create
    @user = User.new(
        name: params[:name],
        email: params[:email],
        image_name: "default_user.jpg",
        password: params[:password]
      )
    @user.save
    redirect_to("/")
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy
  
  end

  def login_form

  end

  def login
    @user = User.find_by(email: params[:email] , password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      render("/users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

end
