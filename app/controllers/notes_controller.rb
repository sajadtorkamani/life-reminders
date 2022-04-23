# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!

  # GET /notes/new
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user

    if @note.save
      redirect_to root_path, notice: t('notices.notes.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end

