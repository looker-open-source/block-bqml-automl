connection: "@{CONNECTION_NAME}"

include: "/views/*.view"

explore: census_income_predictions {
  view_name: model_name
  label: "AutoML Tables: Census Income Predictions"
  description: "Use this Explore to create regression and classification models for advanced analytics using U.S. Census income data"

 always_filter: {
    filters: [model_name.select_model_name: ""]
  }

  join: census_income_predictions_input_data {
    type: cross
    relationship: one_to_many
  }

  join: census_income_predictions_automl_training_data {
    sql:  ;;
  relationship: many_to_one
}

  join: automl_hyper_params {
    sql:  ;;
  relationship: many_to_one
  }

  join: census_income_predictions_automl_create_model {
    sql:  ;;
  relationship: many_to_one
  }

  join: automl_evaluate {
    type: cross
    relationship: many_to_many
  }

  join: automl_predict {
    type: full_outer
    sql_on: ${census_income_predictions_input_data.id} = ${automl_predict.input_data_primary_key} ;;
    relationship: one_to_one
  }

  join: automl_feature_info {
    type: cross
    relationship: many_to_many
  }
}
