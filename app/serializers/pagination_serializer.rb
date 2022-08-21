class PaginationSerializer < ActiveModel::Serializer
  attributes :items, :total_items, :total_pages
end
