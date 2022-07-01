# frozen_string_literal: true
class Partnership < ApplicationRecord
  enum started_at_resolution: {
    day:   0,
    month: 1,
    year:  2
  }
end
