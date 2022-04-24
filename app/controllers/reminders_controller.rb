# frozen_string_literal: true

class RemindersController < ApplicationController
  before_action :authenticate_user!

  # GET /reminders
  def index
    @reminders = Reminder.where(user: current_user)
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

  private

  def reminder_params
    params.require(:reminder).permit(:name, :number_of_notes)
  end
end
