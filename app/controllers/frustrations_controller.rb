class FrustrationsController < ApplicationController
  # GET /frustrations
  # GET /frustrations.json
  def index
    @frustrations = Frustration.page(params[:page]).per_page(10)
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frustrations }
      format.js
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
        current_user.level += 1
        current_user.save
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
    
    # level up the user
    unless current_user.nil?
        unless current_user.level >= 100
            current_user.level += 1
            current_user.save
        end
    end
    
    unless @frustration.user.nil?
        @frustration.user.love += 1
        @frustration.user.save
    end
    
    respond_to do |format|
        format.html { render :nothing => true }
        if !current_user.nil?
            format.json { render json: current_user.level }
        else
            format.json { render :nothing => true }
        end
    end
  end
  
  def add_comment
    logger.debug(params[:content])
    logger.debug(params[:id])
    
    @frustration = Frustration.find(params[:id])
    @frustration.comments.create(:content => params[:content])
    
    respond_to do |format|
        format.json { render json: @frustration.comments.length }
        format.html
    end
  end

  def epic_destruction
    unless current_user.nil?
        if current_user.level >= 100
            # We should first remove frustrations from the registered users
            # and dispatch some mails
            User.all.each do |user|
                user.frustrations.destroy_all
                Notifier.notify_frustration_gone(user).deliver
            end

            # After that we remove the rest of frustrations
            Frustration.destroy_all
            
            current_user.level = 0
            current_user.save
            
            respond_to do |format|
                format.html { redirect_to root_path, notice: "The world is beautiful again" }
                format.json { render json: Frustration.count }
            end
        else
            respond_to do |format|
                format.html { redirect_to root_path, notice: "You don't have anough love to perform this action" }
                format.json { render json: Frustration.count }
            end
        
        end
    end
    
  end

  # PUT /frustrations/1
  # PUT /frustrations/1.json
  def update
    # instead of updating existing one, let's create a new frustration
    # this way we disable editing of existing frustrations for users
    
    unless current_user.nil?
        @frustration = current_user.frustrations.build(params[:frustration])
        current_user.level += 1
        current_user.save
    else
        @frustration = Frustration.new(params[:frustration])
    end

    respond_to do |format|
      if @frustration.save
        format.html { redirect_to root_path, notice: 'Frustration added' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_path, notice: 'Something went wrong' }
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
      format.js
    end
  end
  
end
