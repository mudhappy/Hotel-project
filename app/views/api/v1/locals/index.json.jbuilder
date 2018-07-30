json.data do
  json.array! @locals do |local|
    json.partial! 'local', local: local
  end
end