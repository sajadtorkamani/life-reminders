# frozen_string_literal: true

class ReminderPolicy < ApplicationPolicy
  def update?
    owner?
  end

  def destroy?
    owner?
  end

  class Scope < Scope
  end
end
