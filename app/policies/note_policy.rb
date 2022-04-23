# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
  def update?
    owner?
  end

  def destroy?
    owner?
  end
end
