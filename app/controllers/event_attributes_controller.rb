class EventAttributesController < ApplicationController
  before_action :redirect_if_user_not_admin
  before_action :set_event_attribute_or_redirect, only: [:show, :edit, :update, :destroy]
  before_action :set_attribute_types, only: [:new, :edit]

  # GET /event_attributes
  # GET /event_attributes.json
  def index
    @event_attributes = EventAttribute.all
  end

  # GET /event_attributes/1
  # GET /event_attributes/1.json
  def show
  end

  # GET /event_attributes/new
  def new
    @event_attribute = EventAttribute.new
  end

  # GET /event_attributes/1/edit
  def edit
  end

  # POST /event_attributes
  # POST /event_attributes.json
  def create
    @event_attribute = EventAttribute.new(event_attribute_params)

    respond_to do |format|
      if @event_attribute.save
        format.html { redirect_to @event_attribute.event, notice: 'Event attribute was successfully created.' }
        format.json { render :show, status: :created, location: @event_attribute }
      else
        format.html { render :new }
        format.json { render json: @event_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_attributes/1
  # PATCH/PUT /event_attributes/1.json
  def update
    respond_to do |format|
      if @event_attribute.update(event_attribute_params)
        format.html { redirect_to @event_attribute, notice: 'Event attribute was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_attribute }
      else
        format.html { render :edit }
        format.json { render json: @event_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_attributes/1
  # DELETE /event_attributes/1.json
  def destroy
    @event_attribute.destroy
    respond_to do |format|
      format.html { redirect_to event_attributes_url, notice: 'Event attribute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_attribute_or_redirect
      @event_attribute = EventAttribute.find_by id: params[:id]
      return if @event_attribute

      redirect_to :root
    end

    def set_attribute_types
      @attribute_types = ['radio_button', 'check_box', 'text_field', 'select',
                          'plain_text']
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_attribute_params
      params.require(:event_attribute).permit(:event_id, :attribute_type, :attribute_value, :attribute_label, :name)
    end
end
