# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!

  # GET /notes
  def index
    @notes = Note.where(user: current_user).order(created_at: :desc)
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # POST /notes
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

