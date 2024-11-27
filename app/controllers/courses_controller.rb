class CoursesController < ApplicationController
  include Authorization

  before_action :authenticate_user!
  before_action :ensure_can_create_class, only: [ :new, :create ]
  # before_action :ensure_teacher, only: [:edit, :update, :destroy]

  def new
    @course = Course.new
  end

  def create
    @class = current_user.created_courses.build(course_params)
    if @class.save
      redirect_to @class, notice: "Course was successfully created."
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(
      :name,
      :start_date,
      :end_date,
      :subject_id,
    )
  end
end
