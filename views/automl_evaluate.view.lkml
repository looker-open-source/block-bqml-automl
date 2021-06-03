view: automl_evaluate {
  label: "[6] AutoML: Evaluation Metrics"

  sql_table_name: @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_evaluate ;;


  # AUTOML_REGRESSOR DIMENSIONS

  dimension: mean_absolute_error {
    group_label: "Metrics for Models with Numerical Targets"
    type: number
    sql: ${TABLE}.mean_absolute_error ;;
  }

  dimension: mean_squared_error {
    group_label: "Metrics for Models with Numerical Targets"
    type: number
    sql: ${TABLE}.mean_squared_error ;;
  }

  dimension: mean_squared_log_error {
    group_label: "Metrics for Models with Numerical Targets"
    type: number
    sql: ${TABLE}.mean_squared_log_error ;;
  }

  dimension: median_absolute_error {
    group_label: "Metrics for Models with Numerical Targets"
    type: number
    sql: ${TABLE}.median_absolute_error ;;
  }

  dimension: r2_score {
    group_label: "Metrics for Models with Numerical Targets"
    type: number
    sql: ${TABLE}.r2_score ;;
  }

  dimension: explained_variance {
    group_label: "Metrics for Models with Numerical Targets"
    type: number
    sql: ${TABLE}.explained_variance ;;
  }


  # AUTOML_CLASSIFIER DIMENSIONS

  dimension: precision {
    group_label: "Metrics for Models with Categorical Targets"
    type: number
    sql: ${TABLE}.precision ;;
  }

  dimension: recall {
    group_label: "Metrics for Models with Categorical Targets"
    type: number
    sql: ${TABLE}.recall ;;
  }

  dimension: accuracy {
    group_label: "Metrics for Models with Categorical Targets"
    type: number
    sql: ${TABLE}.accuracy ;;
  }

  dimension: f1_score {
    group_label: "Metrics for Models with Categorical Targets"
    type: number
    sql: ${TABLE}.f1_score ;;
  }

  dimension: log_loss {
    group_label: "Metrics for Models with Categorical Targets"
    type: number
    sql: ${TABLE}.log_loss ;;
  }

  dimension: roc_auc {
    group_label: "Metrics for Models with Categorical Targets"
    label: "ROC AUC"
    type: number
    sql: ${TABLE}.roc_auc ;;
  }
}
