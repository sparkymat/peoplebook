# frozen_string_literal: true
class Person < ApplicationRecord
  has_one :regular_child_relation, -> { merge(ChildRelation.regular) }, foreign_key: :child_id, class_name: "ChildRelation"
  has_one :biological_child_relation, -> { merge(ChildRelation.biological) }, foreign_key: :child_id, class_name: "ChildRelation"
has_one :adopted_child_relation, -> { merge(ChildRelation.adopted) }, foreign_key: :child_id, class_name: "ChildRelation"

  enum gender: {
    male:   "male",
    female: "female",
    other:  "other",
  }

  def self.sibling_relation(gender)
    {
      "female" => :sister,
      "male"   => :brother,
    }[gender]
  end

  def self.parent_relation(gender)
    {
      "female" => :mother,
      "male"   => :father,
    }[gender]
  end

  def regular_child_relations
  end

  def relations
    relations = []

    # As a regular child
    if regular_child_relation&.partnership.present?

      parents = regular_child_relation.partnership.slice(:person1, :person2).values

      relations += parents.map do |p|
        {
          relation: :parent,
          person: p,
          links: [
            "ChildRelation##{regular_child_relation.id}",
            "Partnership##{regular_child_relation.partnership_id}",
          ]
        }
      end
    end

    # As a parent
    
    relations
  end
end
