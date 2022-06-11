class CoursesController < ApplicationController
  def create
    result = CourseServices::Create.new(create_params)
    response = result.execute

    if response.errors.present?
      render json: { errors: response.errors, error: response.errors.join(', ') }, status: :bad_request
    else
      render json: { user: response.result.as_json }, status: :ok
    end
  end

  private

  def create_params
    params.permit(
      course: [
        :course_title,
        :course_description,
        :course_length,
        :course_start_date,
        :course_end_date,
        :author_id
      ]
    )
  end
end
