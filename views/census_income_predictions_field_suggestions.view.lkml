# Pull the field names from the SQL select statement defined in INPUT_DATA view
# in order to provide field suggestions for the select_features and select_target parameters

view: census_income_predictions_field_suggestions {
    derived_table: {
      sql:  SELECT REGEXP_REPLACE(SPLIT(pair, ':')[OFFSET(0)], r'^"|"$', '') AS column_name
          FROM (
                SELECT * FROM ${census_income_predictions_input_data.SQL_TABLE_NAME}
                LIMIT 1) t,
          UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t), r'{|}', ''), ',"')) pair
    ;;
    }

    dimension: column_name {}

  }
