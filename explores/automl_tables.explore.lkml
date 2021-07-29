include: "/views/*.view"

explore: automl_tables {
  extension: required
  view_name: model_name
  group_label: "Looker + BigQuery ML"
  description: "Use this Explore to create regression and classification models for advanced analytics using NYC taxi data"
  persist_for: "0 minutes"

  always_filter: {
    filters: [model_name.select_model_name: ""]
  }

  join: input_data {
    type: cross
    relationship: one_to_many
  }

  join: automl_training_data {
    sql:  ;;
    relationship: many_to_one
  }

  join: automl_hyper_params {
    sql:  ;;
    relationship: many_to_one
  }

  join: automl_create_model {
    sql:  ;;
    relationship: many_to_one
  }

  join: automl_evaluate {
    type: cross
    relationship: many_to_many
  }

  join: automl_predict {
    type: cross
    relationship: many_to_many
  }

  join: automl_feature_info {
    type: cross
    relationship: many_to_many
  }
}
