class Api::JournalTypesController < ApplicationController
  def index
    @journal_types = JournalType.all
  end
end
