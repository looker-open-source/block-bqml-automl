include: "/views/*.view"

explore: automl_lr_tables {
  extension: required
  view_name: model_name
  group_label: "Advanced Analytics with BQML"
  description: "Use this Explore to create logistic regression models for advanced analytics using NYC taxi data"

  always_filter: {
    filters: [model_name.select_model_name: ""]
  }

  join: automl_training_data {
    sql:  ;;
  relationship: one_to_one
}

join: automl_create_model {
  sql:  ;;
relationship: one_to_one
}

join: automl_evaluate {
  type: cross
  relationship: many_to_many
}

join: input_data {
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
