class SipServersController < ApplicationController
  # GET /sip_servers
  # GET /sip_servers.xml
  def index
    @sip_servers = SipServer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sip_servers }
    end
  end

  # GET /sip_servers/1
  # GET /sip_servers/1.xml
  def show
    @sip_server = SipServer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sip_server }
    end
  end

  # GET /sip_servers/new
  # GET /sip_servers/new.xml
  def new
    @sip_server = SipServer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sip_server }
    end
  end

  # GET /sip_servers/1/edit
  def edit
    @sip_server = SipServer.find(params[:id])
  end

  # POST /sip_servers
  # POST /sip_servers.xml
  def create
    @sip_server = SipServer.new(params[:sip_server])

    respond_to do |format|
      if @sip_server.save
        format.html { redirect_to(@sip_server, :notice => 'Sip server was successfully created.') }
        format.xml  { render :xml => @sip_server, :status => :created, :location => @sip_server }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sip_server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sip_servers/1
  # PUT /sip_servers/1.xml
  def update
    @sip_server = SipServer.find(params[:id])

    respond_to do |format|
      if @sip_server.update_attributes(params[:sip_server])
        format.html { redirect_to(@sip_server, :notice => 'Sip server was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sip_server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sip_servers/1
  # DELETE /sip_servers/1.xml
  def destroy
    @sip_server = SipServer.find(params[:id])
    @sip_server.destroy

    respond_to do |format|
      format.html { redirect_to(sip_servers_url) }
      format.xml  { head :ok }
    end
  end
end