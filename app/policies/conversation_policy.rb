class ConversationPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == conversation.user
  end

  def destroy?
    return true if user.present? && user == conversation.user
  end

  private

  def conversation
    record
  end
end
