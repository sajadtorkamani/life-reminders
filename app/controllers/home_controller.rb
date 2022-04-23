# frozen_string_literal: true

class HomeController < ApplicationController
  # GET /
  def index
    return redirect_to notes_path if user_signed_in?

    render :index
  end
end
