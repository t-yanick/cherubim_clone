class CustomerPolicy < ApplicationPolicy
  def index?
    cherubim_user&.role&.read_customers?
  end

  def show?
    cherubim_user&.role&.read_customers?
  end

  def create?
    cherubim_user&.role&.create_customers?
  end

  def update?
    cherubim_user&.role&.update_customers?
  end

  def destroy?
    cherubim_user&.role&.delete_customers?
  end
end
