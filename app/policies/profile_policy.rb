class ProfilePolicy < ApplicationPolicy
  def update?
    return true if user.present? && user == profile.user
  end

  def destroy?
    return true if user.present? && user == profile.user
  end

  private

    def profile
      record
    end
end
