class CustomerPolicy < ApplicationPolicy
  def index?
    user&.role&.read_customers?
  end

  def show?
    user&.role&.read_customers?
  end

  def create?
    user&.role&.create_customers?
  end

  def update?
    user&.role&.update_customers?
  end

  def destroy?
    user&.role&.delete_customers?
  end
end
