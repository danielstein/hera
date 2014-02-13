json.array!(@equipment) do |equip|
  json.extract! equip, :id, :is_there, :creation_date, :equip_type_id, :building_id, :name, :floor, :id_place
  json.equip_type_kind equip.equip_type.kind
end
