class StylesController < ApplicationController
  before_filter :ensure_that_signed_in, except: [:index, :new, :show]

  def index
    @styles = Style.all
  end

  def show
    @style = Style.find(params[:id])
  end

  def new
    @style = Style.new
  end

  def edit
    @style = Style.find(params[:id])
  end

  def create
    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save
        format.html { redirect_to @style, notice: 'Style was successfully created.' }
        format.json { render action: 'show', status: :created, location: @style }
      else
        format.html { render action: 'new' }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @style = Style.find(params[:id])

    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to @style, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def style_params
    params.require(:style).permit(:name, :description)
  end
end