class ReceiptPolicy < ApplicationPolicy
  def index?
    user&.role&.read_receipts?
  end

  def show?
    user&.role&.read_receipts?
  end

  def create?
    user&.role&.create_receipts?
  end

  def update?
    user&.role&.update_receipts?
  end

  def destroy?
    user&.role&.delete_receipts?
  end
end
