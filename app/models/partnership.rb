# frozen_string_literal: true
class Partnership < ApplicationRecord
  belongs_to :person1, class_name: "Person"
  belongs_to :person2, class_name: "Person"
end
