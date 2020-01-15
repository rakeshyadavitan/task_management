class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:dashboard]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :project, :except => [:edit_status, :update_status]

  
  def dashboard
    if current_user.present? && current_user.role?(:admin)
      @todos = Todo.select("todos.title, todos.status, users.name").joins(:user).where("true").group_by(&:status)#.group("todos.status,todos.title")#.references(:todos)
      @devs = User.where(role: 1).select(:name).order(:id)
      @todos_p = Todo.select("todos.title, todos.status, projects.name").joins(:project).where("true").group_by(&:status)
      @projects = Project.where("true").select(:name, :id).order(:id)
      project_id = params[:project].present? ? params[:project] : 1
      @graph_data = Todo.includes(:project).where(project_id: project_id).select("status, project_id").group_by(&:status).collect{|k , v | [k, v.count]}
    elsif current_user.present? && current_user.role?(:developer)
      @todos = Todo.where(user_id: current_user.id)
    end
  end

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.todos.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_status
    @todo = Todo.find(params[:id])
  end

  def update_status
    @todo = Todo.find(params[:id])
    respond_to do |format|
      if @todo.update_attributes(todo_params)
        format.html { redirect_to dashboard_projects_path, notice: 'Todo was successfully updated.' }
        format.json { render :dashboard, status: :ok, location: dashboard_projects_path }
      else
        format.html { render :edit_status }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, todos_attributes: [:id, :title, :user_id, :status,:_destroy])
    end
    def todo_params
      params.require(:todo).permit(:status)
    end
end
