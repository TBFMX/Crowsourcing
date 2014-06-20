class PerksController < ApplicationController
  before_action :set_perk, only: [:show, :edit, :update, :destroy,:prosses_pay]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
    #quitar cuando acaben las pruebas flash
    require 'paypal-sdk-rest'
    #include  PayPal::SDK::REST
      include Porta

  # GET /perks
  # GET /perks.json
  def index
    if params[:id].nil?
      redirect_to root_path
    end 
    @perks = Perk.where("project_id" => params[:id])
    add_breadcrumb I18n.t("breadcrumbs.perks"), '/projects/perks/' + @project.id.to_s 
    @permiso = check_propiety(@project)
  end

  # GET /perks/1
  # GET /perks/1.json
  def show
    @project = Project.find(@perk.project_id)
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
  end

  # GET /perks/new/proyecto_id
  def new
    @project = params[:id]
    @perk = Perk.new
    @project2 = Project.find(@project)
    add_breadcrumb @project2.name.to_s, '/projects/' + @project2.id.to_s
    @gallery = Gallery.where("project_id = ?",@project)
    @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to root_path
    end
  end

  # GET /perks/1/edit/proyecto_id
  def edit
    @project = params[:proy]
    @project2 = Project.find(@project)
    add_breadcrumb @project2.name.to_s, '/projects/' + @project2.id.to_s
    @gallery = Gallery.where("project_id = ?",@project)
        puts "-------------------galeria---------------------------"
      puts @gallery.inspect
    puts "-------------------------------------------------"
    @permiso = check_propiety(@project2)
    unless @permiso 
      redirect_to root_path
    end
  end

  # POST /perks
  # POST /perks.json
  def create
    @perk = Perk.new(perk_params)

    @pic = params[:perk][:image_id]
    @project = params[:perk][:project_id]
    @gallery = params[:gallery_id]
    puts "-------------------galleria---------------------------"
      puts @gallery.inspect
    puts "------------------------------------------------------"

    @project2 = Project.find(@project)
    @gallery2 = Gallery.find(@gallery)

    unless @pic.nil?
      @pics = DataFile.save(@pic,@project2.name,@gallery2.title)

      @image = Image.new("galery_id" => @gallery, "image_url" => @pics)
      puts "--------------------Imagen--------------------------"
      puts @image.inspect
      puts "----------------------------------------------"

      respond_to do |format|
        if @image.save
            format.html { 
              puts "------------------------------------------------------------------"
              puts @image.id
              puts "------------------------------------------------------------------"
              respond_to do |format|
                if @perk.save
                  format.html { 
                    respond_to do |format|
                      if @perk.update("image_id"=> @image.id)
                        if session[:url_to_return].blank?
                          url = "/projects/" + @project
                        else
                          url = session[:url_to_return]
                          session[:url_to_return] = ""
                        end  
                        format.html {  redirect_to url, notice: 'Perk was successfully updated.' }
                        format.json { render :show, status: :ok, location: @perk }
                      else
                        format.html { render :edit }
                        format.json { render json: @perk.errors, status: :unprocessable_entity }
                      end
                    end  
                    }
                  format.json { render :show, status: :ok, location: @perk }
                else
                  format.html { render :edit }
                  format.json { render json: @perk.errors, status: :unprocessable_entity }
                end
              end
            }
            format.json { }
        end
      end
    else
      respond_to do |format|
        if @perk.save
          if session[:url_to_return].blank?
            url = "/projects/" + @project
          else
            url = session[:url_to_return]
            session[:url_to_return] = ""
          end  
          format.html {  redirect_to url, notice: 'Perk was successfully updated.' }
          format.json { render :show, status: :ok, location: @perk }
        else
            format.html { render :edit }
            format.json { render json: @perk.errors, status: :unprocessable_entity }
        end
      end    
      @pics = " "  
    end
  end

  # PATCH/PUT /perks/1
  # PATCH/PUT /perks/1.json
  def update
    #recupero datos
    @pic = params[:perk][:image_id]
    @project = params[:perk][:project_id]
    @gallery = params[:gallery_id]
    puts "-------------------Pic---------------------------"
      puts @gallery.inspect
    puts "-------------------------------------------------"
    @project2 = Project.find(@project)
    @gallery2 = Gallery.find(@gallery)

    unless @pic.nil?
      @pics = DataFile.save(@pic,@project2.name,@gallery2.title)

      @image = Image.new("galery_id" => @gallery, "image_url" => @pics)
      puts "--------------------Imagen--------------------------"
      puts @image.inspect
      puts "----------------------------------------------"

      respond_to do |format|
        if @image.save
            format.html { 
              puts "------------------------------------------------------------------"
              puts @image.id
              puts "------------------------------------------------------------------"
              respond_to do |format|
                if @perk.update(perk_params)
                  format.html { 
                    respond_to do |format|
                      if @perk.update("image_id"=> @image.id)
                        if session[:url_to_return].blank?
                          url = "/projects/" + @project
                        else
                          url = session[:url_to_return]
                          session[:url_to_return] = ""
                        end  
                        format.html {  redirect_to url, notice: 'Perk was successfully updated.' }
                        format.json { render :show, status: :ok, location: @perk }
                      else
                        format.html { render :edit }
                        format.json { render json: @perk.errors, status: :unprocessable_entity }
                      end
                    end  
                    }
                  format.json { render :show, status: :ok, location: @perk }
                else
                  format.html { render :edit }
                  format.json { render json: @perk.errors, status: :unprocessable_entity }
                end
              end
            }
            format.json { }
        end
      end
    else
      respond_to do |format|
        if @perk.update(perk_params)
          if session[:url_to_return].blank?
            url = "/projects/" + @project
          else
            url = session[:url_to_return]
            session[:url_to_return] = ""
          end  
          format.html {  redirect_to url, notice: 'Perk was successfully updated.' }
          format.json { render :show, status: :ok, location: @perk }
        else
            format.html { render :edit }
            format.json { render json: @perk.errors, status: :unprocessable_entity }
        end
      end    
      @pics = " "  
    end
    
    

  end

  # DELETE /perks/1
  # DELETE /perks/1.json
  def destroy
    @project = Project.find(@perk.project_id)

    @perk.destroy
    respond_to do |format|
      format.html { redirect_to '/projects/' + @project.id.to_s, notice: 'Perk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #prosses_pay/1
  def prosses_pay
    @perk = Perk.find(params[:id])

    
  end  

  def paypal
    @perk = Perk.find(params[:id])
    session[:lastperk]= @perk

    #falta cambiar ligas de recepcion



  PayPal::SDK::REST.set_config(
    :mode => "sandbox", # "sandbox" or "live"
    :client_id => "AUsuAxDDr6_WcMNrnWkpdiKl6UoNZT9YTcT-n2Cd1BpGU386PFJaw6TBhADy",
    :client_secret => "ENy1ehBI9RRdcP8800N5B7GZt8ZEclcxca8UYRAtZcSLGA7haQFpMdRmmceg")
    #@pago= :params[:all]
    @total = sprintf("%0.02f", @perk.price)
    #@total = @cart.total_price.to_d
    @payment = PayPal::SDK::REST::Payment.new({
    :intent => "sale",
    :redirect_urls => {
        :return_url => "http://google.com",
        :cancel_url => "http://google.com"},
    :payer => {
      :payment_method => "paypal"
    },
    :transactions => [{
      :amount => {
        :total => @total,
        :currency => "MXN",
        :details => {
          :subtotal => @total,
          :tax => "0.00",
          :shipping => "0.00"}},
      :description => @perk.description }]})

    if @payment.create
      respuesta = true  
      @T_id = @payment.id     # Payment Id
      session[:lastid]= @T_id
      #puts respuesta
      #puts  @T_id
      #######################################################################################################################
      get_payment_details(@T_id)
      ########################################################################################################################
      #execute_payment(@T_id) #<-- no se esta usado aqui sino en "pago_paypal"

    else
      respuesta = false 
      @T_error = @payment.error  # Error Hash
      #puts respuesta
      #puts @T_error
    end
  end

  def pago_paypal
    pl_id = "EbKhU8rtN4qSqgbW1IKYCA"
    #pl_id = params[:PayerID]
    #HquhU5H-LZKHqgbRgYHABA
    execute_payment(session[:lastid],pl_id,session[:lastperk])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perk
      @perk = Perk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perk_params
      params.require(:perk).permit(:title, :description, :delivery_date, :price, :pieces, :project_id)
    end

    #metodos para paypal
    def get_notification(mp,trans_id)
      paymentInfo = mp.get_payment_info(trans_id)

      return paymentInfo
    end

  def get_payment_details(pp_id)
    # Fetch Payment
    payment = PayPal::SDK::REST::Payment.find(pp_id)

    # Get List of Payments
    payment_history = PayPal::SDK::REST::Payment.all( :count => 5 )
    @grid = payment_history.payments #<--para grid

    @ligas = Array.new
    contador = 0

    @grid.each do |dante|

      dante.links.each do |kalos|
        @ligas[contador] = kalos.href
        contador += 1
      end
    end
    @ligapp = @ligas[1]

    #redirect_to @ligapp
  end

  def execute_payment(pp_id,pl_id,perk)
    #payment = PayPal::SDK::REST::Payment.find(pp_id)
    payment = PayPal::SDK::REST::Payment.find("PAY-2PU736669C563082FKOQ3JOY")
    if payment.execute( :payer_id => "DUFRQ8GWYMJXC" )
      # Success Message
      @mensajePP = "el pago se realizo con exito"

      #creamos el founder
      create_founder(perk)


    else
      @mensajePP = payment.error # Error Hash
    end
  end 
  #terminan metodos de paypal

  #creador de funders
  def create_founder(perk)
    @user = session[:user_id]
    @project = Project.where("perk_id = ?", perk)
    @funder = Funder.new("user_id" => @user, "perk_id" =>perk, "project_id" => @project)


    respond_to do |format|
      if @funder.save
        format.html { redirect_to @project}
        format.json { render :show, status: :created, location: @funder }
      else
        format.html { render :new }
        format.json { render json: @funder.errors, status: :unprocessable_entity }
      end
    end
  end 

end
