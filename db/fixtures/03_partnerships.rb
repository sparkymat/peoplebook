# frozen_string_literal: true
Partnership.seed(:id,
  {id: 1, person1_id: 2, person2_id: 3, started_at: DateTime.parse("1979-01-01")},
  {id: 2, person1_id: 4, person2_id: 5, started_at: DateTime.parse("1969-01-01")},
)
