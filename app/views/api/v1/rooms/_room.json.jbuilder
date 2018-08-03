json.call(
  room,
  :price,
  :dni,
  :roomer_quantities,
  :left_at,
  :created_at
)

json.rooms_type(
  room.rooms_type,
  :id,
  :name
)

json.rooms_state(
  room.rooms_state,
  :id,
  :name
)
