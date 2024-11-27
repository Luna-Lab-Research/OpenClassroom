# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  private

  def ensure_admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to access this area"
      redirect_to root_path
    end
  end

  def ensure_can_create_class
    unless current_user&.can_create_class?
      flash[:alert] = "You don't have permission to create classes"
      redirect_to root_path
    end
  end

  def ensure_teacher
    unless current_user&.teacher_of?(@class)
      flash[:alert] = "You must be a teacher in this class"
      redirect_to root_path
    end
  end
end
