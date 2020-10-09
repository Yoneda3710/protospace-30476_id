class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    #@name = current_user.nickname
    @prototypes = @user.prototypes

  end
end
