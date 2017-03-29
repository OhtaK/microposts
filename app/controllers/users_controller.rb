class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!!!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user=User.find(params[:id])
    if(current_user!=@user)
    redirect_to root_path
    end
  end
  
  def update
    if current_user.update(user_params)
      # 保存に成功した場合はユーザのページへリダイレクト
      redirect_to current_user, notice: '詳細情報を編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
  @followings  =@user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
  @followers  =@user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end