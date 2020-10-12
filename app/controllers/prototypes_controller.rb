class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    if user_signed_in?
     @user = User.find(current_user.id)
    end
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    if Prototype.create(prototype_params)
      redirect_to root_path
    else
      render 'prototype/new'
    end
  end

  def show 
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.id
      redirect_to action: :index
    end
    
  end

  def update
    if Prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render 'prototype/edit'
    end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
   unless user_signed_in?
     redirect_to action: :index
   end
  end
end
