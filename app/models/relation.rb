# frozen_string_literal: true
class Relation < ApplicationRecord
  belongs_to :from, class_name: "Person"
  belongs_to :to, class_name: "Person"

  enum relation_type: %i[
    brother
    sister
    father
    mother
    son
    daughter
    aunt
    uncle
    grandfather
    grandmother
    grandson
    granddaughter
    nephew
    niece
  ].to_h { |s| [s,s.to_s] }
end
