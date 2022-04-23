# frozen_string_literal: true

class HomeController < ApplicationController
  # GET /
  def index
    if user_signed_in?
      return redirect_to notes_path
    end

    render :index
  end
end
