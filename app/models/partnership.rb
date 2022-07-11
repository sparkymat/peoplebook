# frozen_string_literal: true
class Partnership < ApplicationRecord
  belongs_to :person1, class_name: "Person"
  belongs_to :person2, class_name: "Person"

  has_many :child_relations

  scope :for_person, lambda { |pid| where("person1_id = ? OR person2_id = ?", pid, pid) }
end
