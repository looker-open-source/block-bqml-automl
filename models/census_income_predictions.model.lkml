connection: "@{CONNECTION_NAME}"

include: "/explores/automl_tables.explore"

explore: census_income_predictions {
  label: "AutoML Tables: Census Income Predictions"
  description: "Use this Explore to create regression and classification models for advanced analytics using U.S. Census income data"

  extends: [automl_tables]

  join: automl_predict {
    type: full_outer
    sql_on: ${input_data.id} = ${automl_predict.input_data_primary_key} ;;
    relationship: one_to_one
  }
}
