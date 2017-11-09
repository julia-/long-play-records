class MessagePolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == message.user
  end

  def destroy?
    return true if user.present? && user == message.user
  end

  private

  def message
    record
  end
end
