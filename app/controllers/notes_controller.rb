# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[edit update]

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
      redirect_to notes_path, notice: t('notices.notes.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /notes/:id/edit
  def edit; end

  # PUT /notes/:id
  def update
    if @note.update(note_params)
      redirect_to notes_path, notice: t('notices.notes.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:content)
  end
end
