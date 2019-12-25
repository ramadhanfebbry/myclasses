class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]

  def index
    @classrooms = Classroom.all
  end

  def show
  end

  def new
    @classroom = Classroom.new
  end

  def edit
  end

  def create
    @classroom = Classroom.new(classroom_params)

    if @classroom.save
      redirect_to @classroom, notice: 'Classroom was successfully created.'        
    else
      render :new 
    end
    
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to @classroom, notice: 'Classroom was successfully updated.' 
      render :show, status: :ok, location: @classroom 
    else
      render :edit 
    end    
  end

  def destroy
    @classroom.destroy
  
    redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.'       
  end

  def enroll
    current_user.classrooms << Classroom.find(params[:id])
    
    flash[:success] = 'Classroom was successfully enrolled'
    redirect_to root_path    
  end

  def enrolled
    @classroom = Classroom.find(params[:id])
    @users = @classroom.users
  end
  

  def my_classes
    @classrooms = current_user.classrooms
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:name, :description)
    end
end
