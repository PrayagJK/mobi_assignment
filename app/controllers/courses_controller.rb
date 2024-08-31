class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  def index
    @courses = Course.includes(:tutors).all
    render json: CourseSerializer.new(@courses).serialized_json
  end

  def show
    render json: CourseSerializer.new(@course).serialized_json
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: CourseSerializer.new(@course).serialized_json, status: :created
    else
      render json: { error: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      render json: CourseSerializer.new(@course).serialized_json
    else
      render json: { error: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.includes(:tutors).find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description)
  end
end