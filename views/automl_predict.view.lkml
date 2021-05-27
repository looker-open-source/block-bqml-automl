view: automl_predict {
  label: "[7] AutoML: Predictions"

  sql_table_name: ML.PREDICT(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model,
                                TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_input_data
                              )
   ;;


  dimension: numeric_prediction {
    description: "Will be NULL for non-numeric categorical predictions. Use the Category Predictions field instead."
    type: number
    sql: ${TABLE}.predicted_input_label_col ;;
  }

  dimension: category_prediction {
    description: "Will be NULL for numeric predictions. Use the Numeric Predictions field instead."
    type: string
    sql:  CASE
            WHEN REGEXP_CONTAINS(CAST(${TABLE}.predicted_input_label_col AS STRING), r"[A-Za-z]") THEN ${TABLE}.predicted_input_label_col
            ELSE NULL
          END
    ;;
  }
}
