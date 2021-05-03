view: model_info {
  sql_table_name: @{looker_temp_dataset_name}.AUTOML_TABLES_MODEL_INFO ;;

  dimension: model_name {
    suggest_persist_for: "0 minutes"
    primary_key: yes
    type: string
    sql: ${TABLE}.model_name ;;
  }

  dimension: target {
    type: string
    sql: ${TABLE}.target ;;
  }

  dimension: features {
    type: string
    sql: ${TABLE}.features ;;
  }

  dimension: budget_hours {
    type: number
    sql: ${TABLE}.budget_hours ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [raw, time]
    sql: ${TABLE}.created_at ;;
  }

  measure: count {
    type: count
    drill_fields: [model_name, created_at_time]
  }
}
