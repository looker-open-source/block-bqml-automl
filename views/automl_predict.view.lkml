view: automl_predict {
  label: "[7] AutoML: Predictions"

  sql_table_name: ML.PREDICT(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model,
                                TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_input_data
                              )
   ;;


  dimension: predicted_target {
    type: string
    sql: ${TABLE}.predicted_input_label_col ;;
  }
}
