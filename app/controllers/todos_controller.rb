class TodosController < ApplicationController
  before_action :set_todo, only: %i[show edit update destroy toggle]

  # GET /todos or /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1 or /todos/1.json
  def show; end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)
    notice = 'Todo was successfully created.'

    respond_to do |format|
      if @todo.save
        format.turbo_stream { render :create, locals: { notice: notice } }
        format.html { redirect_to todos_path, notice: notice }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    @notice = 'Todo was successfully updated.'
    respond_to do |format|
      if @todo.update(todo_params)
        format.turbo_stream
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy
    notice = 'Todo was successfully destroyed.'

    respond_to do |format|
      format.turbo_stream { render :destroy, locals: { notice: notice } }
      format.html { redirect_to todos_url, notice: notice }
    end
  end

  def toggle
    @todo.completed = params.require(:todo).permit(:completed)[:completed]
    respond_to do |format|
      if @todo.save
        format.turbo_stream
        format.html { redirect_to todos_url }
      else
        format.html { redirect_to todos_url }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:content, :completed)
  end
end
