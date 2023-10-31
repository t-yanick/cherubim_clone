class GoodPolicy < ApplicationPolicy
  def index?
    user&.role&.read_goods?
  end

  def show?
    user&.role&.read_goods?
  end

  def create?
    user&.role&.create_goods?
  end

  def update?
    user&.role&.update_goods?
  end

  def destroy?
    user&.role&.delete_goods?
  end
end
