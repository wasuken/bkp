class JournalsController < ApplicationController
  def new
  end

  def index
    @journals = Journal.all
    render "index"
  end

  def show
  end
end
