class ChildRelation < ApplicationRecord
  enum relation_type: {
    regular:    0,
    biological: 1,
    adopted:    2,
  }
end
