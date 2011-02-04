class SipProxiesController < ApplicationController
  # GET /sip_proxies
  # GET /sip_proxies.xml
  def index
    @sip_proxies = SipProxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sip_proxies }
    end
  end

  # GET /sip_proxies/1
  # GET /sip_proxies/1.xml
  def show
    @sip_proxy = SipProxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sip_proxy }
    end
  end

  # GET /sip_proxies/new
  # GET /sip_proxies/new.xml
  def new
    @sip_proxy = SipProxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sip_proxy }
    end
  end

  # GET /sip_proxies/1/edit
  def edit
    @sip_proxy = SipProxy.find(params[:id])
  end

  # POST /sip_proxies
  # POST /sip_proxies.xml
  def create
    @sip_proxy = SipProxy.new(params[:sip_proxy])

    respond_to do |format|
      if @sip_proxy.save
        format.html { redirect_to(@sip_proxy, :notice => 'Sip proxy was successfully created.') }
        format.xml  { render :xml => @sip_proxy, :status => :created, :location => @sip_proxy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sip_proxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sip_proxies/1
  # PUT /sip_proxies/1.xml
  def update
    @sip_proxy = SipProxy.find(params[:id])

    respond_to do |format|
      if @sip_proxy.update_attributes(params[:sip_proxy])
        format.html { redirect_to(@sip_proxy, :notice => 'Sip proxy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sip_proxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sip_proxies/1
  # DELETE /sip_proxies/1.xml
  def destroy
    @sip_proxy = SipProxy.find(params[:id])
    @sip_proxy.destroy

    respond_to do |format|
      format.html { redirect_to(sip_proxies_url) }
      format.xml  { head :ok }
    end
  end
end