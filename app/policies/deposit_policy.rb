class DepositPolicy < ApplicationPolicy
  def index?
    cherubim_user&.role&.read_deposits?
  end

  def show?
    cherubim_user&.role&.read_deposits?
  end

  def create?
    cherubim_user&.role&.create_deposits?
  end

  def update?
    cherubim_user&.role&.update_deposits?
  end

  def destroy?
    cherubim_user&.role&.delete_deposits?
  end
end
