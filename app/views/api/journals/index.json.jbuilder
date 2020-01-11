json.set! :journals do
  json.array! @journals do |journal|
    json.extract! journal, :id, :name, :amount, :jtname, :created_at, :updated_at, :jtid
  end
end
