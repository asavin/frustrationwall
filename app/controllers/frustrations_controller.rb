class FrustrationsController < ApplicationController
  # GET /frustrations
  # GET /frustrations.json
  def index
    @frustrations = Frustration.all
    @frustration = Frustration.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frustrations }
    end
  end

  # GET /frustrations/1
  # GET /frustrations/1.json
  def show
    @frustration = Frustration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frustration }
    end
  end

  # GET /frustrations/new
  # GET /frustrations/new.json
  def new
    @frustration = Frustration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frustration }
    end
  end

  # GET /frustrations/1/edit
  def edit
    @frustration = Frustration.find(params[:id])
  end

  # POST /frustrations
  # POST /frustrations.json
  def create
    unless current_user.nil?
        @frustration = current_user.frustrations.build(params[:frustration])
    else
        @frustration = Frustration.new(params[:frustration])
    end
    

    respond_to do |format|
      if @frustration.save
        format.html { redirect_to root_path, notice: 'Frustration was successfully shared' }
        format.json { render json: @frustration, status: :created, location: @frustration }
      else
        format.html { redirect_to root_path, notice: 'Something went wrong' }
        format.json { render json: @frustration.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_love
    @frustration = Frustration.find(params[:id])
    @frustration.love +=1
    @frustration.save
    respond_to do |format|
        format.html { render :nothing => true }
    end
  end

  # PUT /frustrations/1
  # PUT /frustrations/1.json
  def update
    @frustration = Frustration.find(params[:id])

    respond_to do |format|
      if @frustration.update_attributes(params[:frustration])
        format.html { redirect_to @frustration, notice: 'Frustration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @frustration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frustrations/1
  # DELETE /frustrations/1.json
  def destroy
    @frustration = Frustration.find(params[:id])
    @frustration.destroy

    respond_to do |format|
      format.html { redirect_to frustrations_url }
      format.json { head :no_content }
    end
  end
end
