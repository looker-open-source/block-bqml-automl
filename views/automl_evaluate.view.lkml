view: automl_evaluate {
  label: "[6] AutoML: Evaluation Metrics"

  sql_table_name: ML.EVALUATE(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model) ;;

  dimension: mean_absolute_error {
    type: number
    sql: ${TABLE}.mean_absolute_error ;;
  }

  dimension: mean_squared_error {
    type: number
    sql: ${TABLE}.mean_squared_error ;;
  }

  dimension: mean_squared_log_error {
    type: number
    sql: ${TABLE}.mean_squared_log_error ;;
  }

  dimension: median_absolute_error {
    type: number
    sql: ${TABLE}.median_absolute_error ;;
  }

  dimension: r2_score {
    type: number
    sql: ${TABLE}.r2_score ;;
  }

  dimension: explained_variance {
    type: number
    sql: ${TABLE}.explained_variance ;;
  }
}
