connection: "@{database_connection}"

include: "/explores/automl_tables.explore"
include: "/explores/automl_lr_tables.explore"
include: "/use_case_refinements/nyc_taxi_predictions/*.view"

explore: nyc_taxi_predictions {
  label: "AutoML Tables: NYC Taxi Predictions"
  description: "Use this Explore to create regression and classification models for advanced analytics using NYC taxi data"

  extends: [automl_tables]

  join: automl_predict {
    type: full_outer
    sql_on: ${input_data.trip_id} = ${automl_predict.trip_id} ;;
    relationship: one_to_one
  }
}


explore: nyc_taxi_lr_predictions {
  label: "AutoML Tables: NYC Taxi Predictions - Log Regression"
  description: "Use this Explore to create logistic regression models for advanced analytics using NYC taxi data"

  extends: [automl_lr_tables]

  join: automl_predict {
    type: full_outer
    sql_on: ${input_data.trip_id} = ${automl_predict.trip_id} ;;
    relationship: one_to_one
  }
}
