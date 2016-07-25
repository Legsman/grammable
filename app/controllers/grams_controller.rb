class GramsController < ApplicationController
  before_action :authenticate_grammer!, only: [:new, :create, :edit, :destroy, :update]


   def index
    @grams = Gram.all
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.grammer != current_grammer
    @gram.delete
    redirect_to root_path
  end


  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.grammer != current_grammer
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.grammer != current_grammer

    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else 
      return render :edit, status: :unprocessable_entity
    end
  end

  def show 
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def new
    @gram = Gram.new
  end

  def create
      @gram = current_grammer.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  private 

  def gram_params
    params.require(:gram).permit(:message, :picture)
  end
end
