# frozen_string_literal: true
ChildRelation.seed(:id,
  {id: 1, child_id: 1, partnership_id: 1, relation_type: :regular},
  {id: 2, child_id: 6, partnership_id: 2, relation_type: :regular},
  {id: 3, child_id: 7, partnership_id: 2, relation_type: :regular},
  {id: 4, child_id: 8, partnership_id: 2, relation_type: :regular},
  {id: 5, child_id: 9, partnership_id: 2, relation_type: :regular},
  {id: 6, child_id: 10, partnership_id: 2, relation_type: :regular},
  {id: 7, child_id: 11, partnership_id: 2, relation_type: :regular},
  {id: 8, child_id: 12, partnership_id: 2, relation_type: :regular},
)
