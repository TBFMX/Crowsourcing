class PerksController < ApplicationController
  before_action :set_perk, only: [:show, :edit, :update, :destroy,:prosses_pay]
    #quitar cuando acaben las pruebas flash
    require 'paypal-sdk-rest'
    #include  PayPal::SDK::REST

  # GET /perks
  # GET /perks.json
  def index
    @perks = Perk.all
  end

  # GET /perks/1
  # GET /perks/1.json
  def show
  end

  # GET /perks/new/proyecto_id
  def new
    @project = params[:id]
    @perk = Perk.new
    @gallery = Gallery.where("project_id = ?",@project)
  end

  # GET /perks/1/edit/proyecto_id
  def edit
    @project = params[:proy]
    @gallery = Gallery.where("project_id = ?",@project)
        puts "-------------------galeria---------------------------"
      puts @gallery.inspect
    puts "-------------------------------------------------"
  end

  # POST /perks
  # POST /perks.json
  def create
    @perk = Perk.new(perk_params)

    respond_to do |format|
      if @perk.save
        format.html { redirect_to @perk, notice: 'Perk was successfully created.' }
        format.json { render :show, status: :created, location: @perk }
      else
        format.html { render :new }
        format.json { render json: @perk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perks/1
  # PATCH/PUT /perks/1.json
  def update
    #recupero datos
    @pic = params[:perk][:image_id]
    @project = params[:perk][:project_id]
    @gallery = params[:perk][:galery_id]
    puts "-------------------Pic---------------------------"
      puts @gallery.inspect
    puts "-------------------------------------------------"
    unless @pic.nil?
      @pics = DataFile.save(@pic)
    else
      @pics = " "  
    end
    @image = Image.new("galery_id" => @gallery, "image_url" => @pics)
    puts "--------------------Imagen--------------------------"
    puts @image.inspect
    puts "----------------------------------------------"
    
    respond_to do |format|
      if @image.save
        format.html { 
                  respond_to do |format|
                    if @perk.update(params[:perk][:title], [:perk][:title][:description], [:perk][:title][:delivery_date], [:perk][:title][:price], [:perk][:title][:pieces], [:perk][:title][:project_id], @image.id)
                      format.html { redirect_to @perk, notice: 'Perk was successfully updated.' }
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
     end

  # DELETE /perks/1
  # DELETE /perks/1.json
  def destroy
    @perk.destroy
    respond_to do |format|
      format.html { redirect_to perks_url, notice: 'Perk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #prosses_pay/1
  def prosses_pay
    
  end  

  def paypal
    @perk = Perk.find(params[:id])

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
      #execute_payment(@T_id)

    else
      respuesta = false 
      @T_error = @payment.error  # Error Hash
      #puts respuesta
      #puts @T_error
    end
  end

  def pago_paypal
    pl_id = params[:PayerID]
    execute_payment(session[:lastid],pl_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perk
      @perk = Perk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perk_params
      params.require(:perk).permit(:title, :description, :delivery_date, :price, :pieces, :project_id, :image_id)
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
    payment_history = PayPal::SDK::REST::Payment.all( :count => 1 )
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

    redirect_to @ligapp
  end

  def execute_payment(pp_id,pl_id)
    payment = Payment.find(pp_id)

    if payment.execute( :payer_id => pl_id )
      # Success Message
      @mensajePP = "el pago se realizo con exito"

      #creamos el founder
      #create_founder(perk)


    else
      @mensajePP = payment.error # Error Hash
    end
  end 
  #terminan metodos de paypal

  #creador de funders
  def create_founder(perk)
    @user = session[:user_id]
    @funder = Funder.new("user_id" => @user, "perk_id" =>perk)
    @project = Project.where("perk_id = ?", perk)

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
