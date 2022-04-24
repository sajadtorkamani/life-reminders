# frozen_string_literal: true

class RemindersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reminder, only: %i[edit update destroy]

  # GET /reminders
  def index
    @reminders = Reminder.where(user: current_user).order(created_at: :desc)
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
  end

  # POST /reminders
  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user

    if @reminder.save
      redirect_to reminders_path, notice: t('notices.reminders.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /reminder/:id/edit
  def edit
    authorize @reminder
  end

  # PUT /reminders/:id
  def update
    authorize @reminder

    if @reminder.update(reminder_params)
      redirect_to reminders_path, notice: t('notices.reminders.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reminders/:id
  def destroy
    authorize @reminder
    @reminder.destroy!

    redirect_to reminders_path, notice: t('notices.reminders.deleted'), status: :see_other
  end

  private

  def set_reminder
    @reminder = Reminder.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:name, :number_of_notes)
  end
end
