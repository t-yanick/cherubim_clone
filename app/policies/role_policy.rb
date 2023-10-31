class RolePolicy < ApplicationPolicy
  def index?
    user&.role&.read_roles?
  end

  def show?
    user&.role&.read_roles?
  end

  def create?
    user&.role&.create_roles?
  end

  def update?
    user&.role&.update_roles?
  end

  def destroy?
    user&.role&.delete_roles?
  end
end
