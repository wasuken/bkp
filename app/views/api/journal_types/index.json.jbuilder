json.set! :journal_types do
  json.array! @journal_types do |journal_type|
    json.extract! journal_type, :id, :name
  end
end
