class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_that_admin, only: [:destroy]
  before_filter :ensure_that_signed_in, except: [:index, :show]

  # GET /breweries
  # GET /breweries.json
  def index
    return if fragment_exist?('breweries')

    @active_breweries = Brewery.active.sort_by{ |b| b.send(params[:order] || 'name') }
    @inactive_breweries = Brewery.retired.sort_by{ |b| b.send(params[:order] || 'name') }
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  def toggle_activity
    expire_fragment('breweries')

    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, :notice => "Brewery status changed to #{new_status}"
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    expire_fragment('breweries')

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brewery }
      else
        format.html { render action: 'new' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    expire_fragment('breweries')

    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy

    expire_fragment('breweries')

    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end
end
