class TasksController < ApplicationController
  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(:body => params[:body], :complete => params[:complete])
        format.html { redirect_to @task, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html #{ redirect_to lists_url }
      format.json { head :no_content }
      #format.js { render :layout => false }
    end
  end
end
