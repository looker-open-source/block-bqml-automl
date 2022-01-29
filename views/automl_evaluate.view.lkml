view: automl_evaluate {
  label: "[6] AutoML: Evaluation Metrics"

  sql_table_name: @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_evaluate_{{ _explore._name }} ;;


  # AUTOML_REGRESSOR DIMENSIONS

  dimension: mean_absolute_error {
    group_label: "Metrics for Models with Numerical Targets"
    description: "The mean absolute error (MAE) is the average absolute difference between the target values and the predicted values. This metric ranges from zero to infinity; a lower value indicates a higher quality model."
    type: number
    sql: ${TABLE}.mean_absolute_error ;;
  }

  dimension: mean_squared_error {
    group_label: "Metrics for Models with Numerical Targets"
    description: "Frequently used measure of the differences between the values predicted by a model or an estimator and the values observed. This metric ranges from zero to infinity; a lower value indicates a higher quality model."
    type: number
    sql: ${TABLE}.mean_squared_error ;;
  }

  dimension: mean_squared_log_error {
    group_label: "Metrics for Models with Numerical Targets"
    description: "Similar to mean squared error, except that it uses the natural logarithm of the predicted and actual values plus 1. This metric penalizes under-prediction more heavily than over-prediction. It can also be a good metric when you don't want to penalize differences for large prediction values more heavily than for small prediction values. This metric ranges from zero to infinity; a lower value indicates a higher quality model. The metric is returned only if all label and predicted values are non-negative."
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
    description: "R squared (r^2) is the square of the Pearson correlation coefficient between the labels and predicted values. This metric ranges between zero and one; a higher value indicates a higher quality model."
    type: number
    sql: ${TABLE}.r2_score ;;
  }

  dimension: explained_variance {
    group_label: "Metrics for Models with Numerical Targets"
    description: "The portion of the model’s total variance that is explained by factors that are actually present and isn’t due to error variance. Higher percentages of explained variance indicate better predictions "
    type: number
    sql: ${TABLE}.explained_variance ;;
  }


  # AUTOML_CLASSIFIER DIMENSIONS

  dimension: precision {
    group_label: "Metrics for Models with Categorical Targets"
    description: "The fraction of positive predictions produced by the model that were correct. Positive predictions are the false positives and the true positives combined."
    type: number
    sql: ${TABLE}.precision ;;
  }

  dimension: recall {
    group_label: "Metrics for Models with Categorical Targets"
    description: "True Positive Rate: The fraction of rows with this label that the model correctly predicted"
    type: number
    sql: ${TABLE}.recall ;;
  }

  dimension: accuracy {
    group_label: "Metrics for Models with Categorical Targets"
    description: "The fraction of classification predictions produced by the model that were correct"
    type: number
    sql: ${TABLE}.accuracy ;;
  }

  dimension: f1_score {
    group_label: "Metrics for Models with Categorical Targets"
    description: "The harmonic mean of precision and recall. F1 is a useful metric if you're looking for a balance between precision and recall and there's an uneven class distribution."
    type: number
    sql: ${TABLE}.f1_score ;;
  }

  dimension: log_loss {
    group_label: "Metrics for Models with Categorical Targets"
    description: "Loss increases as the predicted probability diverges from the actual label. A lower log loss value indicates a higher-quality model."
    type: number
    sql: ${TABLE}.log_loss ;;
  }

  dimension: roc_auc {
    group_label: "Metrics for Models with Categorical Targets"
    label: "ROC AUC"
    description: "The area under the receiver operating characteristic (ROC) curve. This ranges from zero to one, where a higher value indicates a higher-quality model."
    type: number
    sql: ${TABLE}.roc_auc ;;
  }
}
