view: automl_feature_info {
  label: "[8] AutoML: Feature Info"

  sql_table_name: ML.FEATURE_INFO(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model_{{ _explore._name }}) ;;

  dimension: input {
    type: string
    sql: ${TABLE}.input ;;
  }

  dimension: min {
    type: number
    sql: ${TABLE}.min ;;
  }

  dimension: max {
    type: number
    sql: ${TABLE}.max ;;
  }

  dimension: mean {
    type: number
    sql: ${TABLE}.mean ;;
    value_format_name: decimal_4
  }

  dimension: median {
    type: number
    sql: ${TABLE}.median ;;
  }

  dimension: stddev {
    type: number
    sql: ${TABLE}.stddev ;;
    value_format_name: decimal_4
  }

  dimension: category_count {
    type: number
    sql: ${TABLE}.category_count ;;
  }

  dimension: null_count {
    type: number
    sql: ${TABLE}.null_count ;;
  }
}
