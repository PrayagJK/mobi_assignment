class TutorsController < ApplicationController
  before_action :set_course
  before_action :set_tutor, only: [:show, :update, :destroy]

  def index
    @tutors = @course.tutors
    render json: TutorSerializer.new(@tutors).serialized_json
  end

  def show
    render json: TutorSerializer.new(@tutor).serialized_json
  end

  def create
    @tutor = @course.tutors.new(tutor_params)
    if @tutor.save
      render json: TutorSerializer.new(@tutor).serialized_json, status: :created
    else
      render json: { error: @tutor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @tutor.update(tutor_params)
      render json: TutorSerializer.new(@tutor).serialized_json
    else
      render json: { error: @tutor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @tutor.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_tutor
    @tutor = @course.tutors.find(params[:id])
  end

  def tutor_params
    params.require(:tutor).permit(:name, :email)
  end
end