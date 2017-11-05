class ProductPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == product.user
  end

  def destroy?
    return true if user.present? && user == product.user
  end

  private

    def product
      record
    end
end
