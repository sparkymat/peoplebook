class ChildRelation < ApplicationRecord
  belongs_to :child, class_name: 'Person'
  belongs_to :partnership

  enum relation_type: {
    regular:    0,
    biological: 1,
    adopted:    2,
  }
end
