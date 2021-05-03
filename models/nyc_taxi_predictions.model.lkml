connection: "@{database_connection}"

include: "/explores/automl_tables.explore"
include: "/use_case_refinements/nyc_taxi_predictions/*.view"

explore: nyc_taxi_predictions {
  label: "AutoML Tables: NYC Taxi Predictions"
  description: "Use this Explore to create regression and classification models for advanced analytics using NYC taxi data"

  extends: [automl_tables]
}
