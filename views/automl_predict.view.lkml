view: automl_predict {
  label: "[7] AutoML: Predictions"

  derived_table: {
    sql:  SELECT ROW_NUMBER() OVER() as pk, *
          FROM ML.PREDICT(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_k_means_model,
                      TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_k_means_training_data
                    )
    ;;
  }

  parameter: select_target {
    label: "Select Target (REQUIRED)"
    description: "Select your model's target field"
    type: unquoted
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }

  dimension: predicted_target {
    type: string
    sql: ${TABLE}.predicted_{% parameter select_target %} ;;
  }
}
