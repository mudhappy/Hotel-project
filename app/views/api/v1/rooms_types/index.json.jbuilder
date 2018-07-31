json.data do
  json.array! @rooms_types do |rooms_type|
    json.partial! 'rooms_type', rooms_type: rooms_type
  end
end