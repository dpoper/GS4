class PhoneModelsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # https://github.com/ryanb/cancan/wiki/authorizing-controller-actions
  load_and_authorize_resource
  
  before_filter { |controller|
    @manufacturers = Manufacturer.accessible_by( current_ability, :index ).order(:name)
  }
  

  # GET /phone_models
  # GET /phone_models.xml
  def index
    @phone_models = PhoneModel.accessible_by( current_ability, :index ).order(:manufacturer_id, :name).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phone_models }
    end
  end

  # GET /phone_models/1
  # GET /phone_models/1.xml
  def show
    @phone_model = PhoneModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @phone_model }
    end
  end

  # GET /phone_models/new
  # GET /phone_models/new.xml
  def new
    @phone_model = PhoneModel.new

    if params[:manufacturer_id].nil?
      @phone_model.manufacturer_id = PhoneModel.last.manufacturer.id
    else
      @phone_model.manufacturer_id = params[:manufacturer_id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phone_model }
    end
  end

  # GET /phone_models/1/edit
  def edit
    @phone_model = PhoneModel.find(params[:id])
    
  end

  # POST /phone_models
  # POST /phone_models.xml
  def create
    @phone_model = PhoneModel.new(params[:phone_model])
    
    respond_to do |format|
      if @phone_model.save
        format.html { redirect_to(@phone_model, :notice => t(:phone_model_created)) }
        format.xml  { render :xml => @phone_model, :status => :created, :location => @phone_model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @phone_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /phone_models/1
  # PUT /phone_models/1.xml
  def update
    @phone_model = PhoneModel.find(params[:id])

    respond_to do |format|
      if @phone_model.update_attributes(params[:phone_model])
        format.html { redirect_to(@phone_model, :notice => t(:phone_model_updated)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @phone_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_models/1
  # DELETE /phone_models/1.xml
  def destroy
    @phone_model = PhoneModel.find(params[:id])
    @phone_model.destroy

    respond_to do |format|
      format.html { redirect_to(phone_models_url) }
      format.xml  { head :ok }
    end
  end
  
end
