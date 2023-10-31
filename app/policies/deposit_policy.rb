class DepositPolicy < ApplicationPolicy
  def index?
    user&.role&.read_deposits?
  end

  def show?
    user&.role&.read_deposits?
  end

  def create?
    user&.role&.create_deposits?
  end

  def update?
    user&.role&.update_deposits?
  end

  def destroy?
    user&.role&.delete_deposits?
  end
end
