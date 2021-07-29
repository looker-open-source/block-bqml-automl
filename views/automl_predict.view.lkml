view: automl_predict {
  label: "[7] AutoML: Predictions"

  sql_table_name: ML.PREDICT(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model_{{ _explore._name }},
                                TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_input_data_{{ _explore._name }}
                              )
   ;;


######################### UPDATE WITH PRIMARY KEY COLUMN FROM INPUT DATA #############################

  dimension: input_data_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

##########################################################################################################

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

  measure: prediction_count {
    label: "Count of Predictions"
    type: count
  }

  measure: average_prediction {
    group_label: "Measure for Numeric Predictions"
    type: average
    sql: ${numeric_prediction} ;;
    value_format_name: decimal_4
  }

  measure: total_prediction {
    group_label: "Measure for Numeric Predictions"
    type: sum
    sql: ${numeric_prediction} ;;
    value_format_name: decimal_4
  }
}
