# frozen_string_literal: true
class Person < ApplicationRecord
  has_one :child_relation, foreign_key: :child_id

  enum gender: {
    male:   "male",
    female: "female",
    other:  "other",
  }

  def find_relations
    relations = []
    if child_relation.present?
      partnership = child_relation.partnership

      # parents
      parents = Person.where(id: partnership.slice(:person1_id, :person2_id).values)
      relations += parents.map{|p| [{"female"=>:mother,"male"=>:father}[p.gender],p,["ChildRelation##{child_relation.id}","Partnership##{partnership.id}"]]}

      # siblings
      sibling_relations = ChildRelation.where(partnership:).where.not(child_id: id).includes(:child)
      relations += sibling_relations.map{|s| [{"female"=>:sister, "male"=>:brother}[s.child.gender], s.child,["ChildRelation##{child_relation.id}","Partnership##{partnership.id}","ChildRelation##{s.id}"]]}
    end

    relations
  end
end
