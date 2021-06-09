connection: "@{database_connection}"

include: "/explores/automl_tables.explore"
include: "/use_case_refinements/census_income_predictions/*"

explore: google_analytics_predictions {
  label: "AutoML Tables: Census Income Predictions"
  description: "Use this Explore to create regression and classification models for advanced analytics using U.S. Census income data"

  extends: [automl_tables]

  join: automl_predict {
    type: full_outer
    sql_on: ${input_data.row_number} = ${automl_predict.row_number} ;;
    relationship: one_to_one
  }
}
