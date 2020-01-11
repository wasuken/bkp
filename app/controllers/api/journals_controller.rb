class Api::JournalsController < ApplicationController
  before_action :authenticate
  def index
    @journals = Journal
                  .joins('join journal_types on journal_types.id = journals.journal_type_id')
                  .joins('join user_journals on journals.id = user_journals.journal_id')
                  .joins('join users on user_journals.user_id = users.id')
                  .where('users.id', current_user.id)
                  .select('journals.*, journal_types.name as jtname, journal_types.id as jtid')
  end
  def create
    p params
    j = Journal.create(name: params[:name],
                       amount: params[:amount],
                       journal_type_id: params[:journal_type_id]
                       user_id: current_user.id)
    j.save
  end
  def update
  end
  def destroy
    target = Journal.where("id = ? and user_id = ?", params[:id], current_user.id).first
    target.destroy unless target.nil?
  end
  private
  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end

  def current_user
    @current_user ||= authenticate
  end
end
