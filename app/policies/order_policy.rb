class OrderPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == order.user
  end

  def destroy?
    return true if user.present? && user == order.user
  end

  private

  def order
    record
  end
end
