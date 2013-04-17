class ListsController < ApplicationController
  # GET /lists
  # GET /lists.json
  def index
    @lists = current_user.lists.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @list = current_user.lists.new(params[:list])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
      format.js { render :layout => false }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /task
  # POST /task.json
  def create_task
    list = current_user.lists.find_by_id(params[:list_id])
    @task = list.tasks.new(:body => params[:body], :complete => params[:complete])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @list, notice: 'Task was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = current_user.lists.new(params[:list])

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  # update all attributes except tasks
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(:x => params[:x], :y => params[:y], :width=>params[:width], :height=>params[:height])
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end
end
