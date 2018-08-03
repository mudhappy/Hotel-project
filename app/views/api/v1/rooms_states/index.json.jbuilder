json.data do
  json.array! @rooms_states do |rooms_state|
    json.partial! 'rooms_state', rooms_state: rooms_state
  end
end