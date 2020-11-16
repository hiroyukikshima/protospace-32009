class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, ]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
    if user_signed_in?
      @current_user = User.find(current_user.id)
    else
      
    end
  end

  def new
    @prototype = Prototype.new

  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path
    else
      @prototype = Prototype.find(params[:id])
      render "prototypes/edit"
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:image, :concept, :catch_copy, :title).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
