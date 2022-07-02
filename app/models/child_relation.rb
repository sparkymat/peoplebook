# frozen_string_literal: true
class ChildRelation < ApplicationRecord
  belongs_to :child, class_name: "Person"
  belongs_to :partnership

  enum relation_type: {
    regular:    "regular",
    biological: "biological",
    adopted:    "adopted",
  }
end
