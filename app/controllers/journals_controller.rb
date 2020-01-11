class JournalsController < ApplicationController
  before_action :authenticate_user!
  def new
    render "new"
  end

  def index
    @token = current_user.token
    render "index"
  end

  def show
    render "show"
  end
end
