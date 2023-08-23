class StylesController < ApplicationController
  def index
    @styles = Style.all
  end

  def show
    @style = Style.find(params[:id])
    @beers = @style.beers
  end

  def destroy
    style = Style.find(params[:id])
    style.destroy
    redirect_to styles_path
  end

  def create
    @style = Style.new(params.require(:style).permit(:name, :description))
    if @style.save
      redirect_to styles_path
    else
      render :new
    end
  end

  def new
    @style = Style.new
  end

  def edit
    @style = Style.find(params[:id])
  end

  def update
    @style = Style.find(params[:id])

    if @style.update(params.require(:style).permit(:name, :description))
      redirect_to styles_path
    else
      render :edit
    end
  end
end
