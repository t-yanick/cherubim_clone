class RolePolicy < ApplicationPolicy
  def index?
    cherubim_user&.role&.read_roles?
  end

  def show?
    cherubim_user&.role&.read_roles?
  end

  def create?
    cherubim_user&.role&.create_roles?
  end

  def update?
    cherubim_user&.role&.update_roles?
  end

  def destroy?
    cherubim_user&.role&.delete_roles?
  end
end
