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
    parents = regular_child_relation.partnership.slice(:person1, :person2).values

    relations = parents.map do |rel|
      {
        relation: :parent,
        person: rel,
        links: [
          "ChildRelation##{regular_child_relation.id}",
          "Partnership##{regular_child_relation.partnership_id}",
        ]
      }
    end

    sibling_relations = ChildRelation.regular.where(partnership_id: regular_child_relation.partnership_id).where.not(id: regular_child_relation.id)
    relations += sibling_relations.map do |rel|
      {
        relation: :sibling,
        person: rel.child,
        links: [
          "ChildRelation##{regular_child_relation.id}",
          "Partnership##{regular_child_relation.partnership_id}",
          "ChildRelation##{rel.id}",
        ]
      }
    end

    relations
  end

  def adopted_child_relations
    parents = adopted_child_relation.partnership.slice(:person1, :person2).values

    relations = parents.map do |rel|
      {
        relation: :adopted_parent,
        person: rel,
        links: [
          "ChildRelation##{adopted_child_relation.id}",
          "Partnership##{adopted_child_relation.partnership_id}",
        ]
      }
    end

    sibling_relations = ChildRelation.where(partnership_id: adopted_child_relation.partnership_id).where.not(id: adopted_child_relation.id)
    relations += sibling_relations.map do |rel|
      {
        relation: :adopted_sibling,
        person: rel.child,
        links: [
          "ChildRelation##{adopted_child_relation.id}",
          "Partnership##{adopted_child_relation.partnership_id}",
          "ChildRelation##{rel.id}",
        ]
      }
    end

    relations
  end

  def biological_child_relations
    parents = biological_child_relation.partnership.slice(:person1, :person2).values

    relations = parents.map do |rel|
      {
        relation: :biological_parent,
        person: rel,
        links: [
          "ChildRelation##{biological_child_relation.id}",
          "Partnership##{biological_child_relation.partnership_id}",
        ]
      }
    end

    sibling_relations = ChildRelation.where(partnership_id: biological_child_relation.partnership_id).where.not(id: biological_child_relation.id)
    relations += sibling_relations.map do |rel|
      {
        relation: :biological_sibling,
        person: rel.child,
        links: [
          "ChildRelation##{biological_child_relation.id}",
          "Partnership##{biological_child_relation.partnership_id}",
          "ChildRelation##{rel.id}",
        ]
      }
    end

    relations
  end

  def relations
    relations = []

    relations += regular_child_relations if regular_child_relation.present?
    relations += adopted_child_relations if adopted_child_relation.present?
    relations += biological_child_relations if biological_child_relation.present?
    
    relations
  end
end
