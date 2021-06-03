connection: "@{database_connection}"

include: "/explores/automl_tables.explore"
include: "/use_case_refinements/google_analytics_predictions/*"

explore: google_analytics_predictions {
  label: "AutoML Tables: Google Analytics Predictions"
  description: "Use this Explore to create regression and classification models for advanced analytics using public GA data"

  extends: [automl_tables]

  join: automl_predict {
    type: full_outer
    sql_on: ${input_data.ga_sessions_id} = ${automl_predict.ga_sessions_id} ;;
    relationship: one_to_one
  }
}
