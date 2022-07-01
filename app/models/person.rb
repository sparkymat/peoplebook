# frozen_string_literal: true
class Person < ApplicationRecord
  enum gender: {
    male:   "male",
    female: "female",
    other:  "other",
  }
end
