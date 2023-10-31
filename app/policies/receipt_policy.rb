class ReceiptPolicy < ApplicationPolicy
  def index?
    cherubim_user&.role&.read_receipts?
  end

  def show?
    cherubim_user&.role&.read_receipts?
  end

  def create?
    cherubim_user&.role&.create_receipts?
  end

  def update?
    cherubim_user&.role&.update_receipts?
  end

  def destroy?
    cherubim_user&.role&.delete_receipts?
  end
end
