# frozen_string_literal: true
class Partnership < ApplicationRecord
  belongs_to :person1, class_name: 'Person'
  belongs_to :person2, class_name: 'Person'

  enum started_at_resolution: {
    day:   0,
    month: 1,
    year:  2
  }
end
