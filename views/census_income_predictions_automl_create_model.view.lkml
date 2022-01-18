include: "/views/automl_create_model.view"

view: census_income_predictions_automl_create_model {
  extends: [automl_create_model]

  derived_table: {
    persist_for: "1 second"

    create_process: {

      sql_step: CREATE OR REPLACE TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_input_data_{{ _explore._name }}
                    AS  SELECT * EXCEPT({% parameter census_income_predictions_automl_training_data.select_target %})
                          , {% parameter census_income_predictions_automl_training_data.select_target %} AS input_label_col
                        FROM ${census_income_predictions_input_data.SQL_TABLE_NAME}
      ;;

        sql_step: CREATE OR REPLACE TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_training_data_{{ _explore._name }}
                    AS  SELECT
                          {% parameter census_income_predictions_automl_training_data.select_target %} AS input_label_col,
                          {% assign features = _filters['census_income_predictions_automl_training_data.select_features'] | sql_quote | remove: '"' | remove: "'" %}
                            {{ features }}
                        FROM ${census_income_predictions_input_data.SQL_TABLE_NAME}
                        WHERE {% parameter census_income_predictions_automl_training_data.select_target %} IS NOT NULL
      ;;

          sql_step: CREATE OR REPLACE MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model_{{ _explore._name }}
                  OPTIONS(
                    {% if census_income_predictions_automl_training_data.select_target_type._parameter_value == 'numerical' %}
                      MODEL_TYPE = 'AUTOML_REGRESSOR'
                    {% elsif census_income_predictions_automl_training_data.select_target_type._parameter_value == 'categorical' %}
                      MODEL_TYPE = 'AUTOML_CLASSIFIER'
                    {% endif %}
                    , INPUT_LABEL_COLS = ['input_label_col']
                    , BUDGET_HOURS = {% parameter automl_hyper_params.set_budget_hours %}
                  )
                  AS (SELECT *
                      FROM @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_training_data_{{ _explore._name }})
      ;;

            sql_step: CREATE TABLE IF NOT EXISTS @{looker_temp_dataset_name}.AUTOML_TABLES_MODEL_INFO
                  (model_name   STRING,
                  target        STRING,
                  target_type   STRING,
                  features      STRING,
                  budget_hours  FLOAT64,
                  created_at    TIMESTAMP,
                  explore       STRING)
    ;;

              sql_step: MERGE @{looker_temp_dataset_name}.AUTOML_TABLES_MODEL_INFO AS T
                USING (SELECT '{% parameter model_name.select_model_name %}' AS model_name,
                      '{% parameter census_income_predictions_automl_training_data.select_target %}' AS target,
                      '{% parameter census_income_predictions_automl_training_data.select_target_type %}' AS target_type,
                      {% assign features = _filters['census_income_predictions_automl_training_data.select_features'] | sql_quote | remove: '"' | remove: "'" %}
                        '{{ features }}' AS features,
                      {% parameter automl_hyper_params.set_budget_hours %} AS budget_hours,
                      CURRENT_TIMESTAMP AS created_at,
                      '{{ _explore._name }}' AS explore
                      ) AS S
                ON T.model_name = S.model_name AND T.explore = S.explore
                WHEN MATCHED THEN
                  UPDATE SET target=S.target
                      , target_type=S.target_type
                      , features=S.features
                      , budget_hours=S.budget_hours
                      , created_at=S.created_at
                WHEN NOT MATCHED THEN
                  INSERT (model_name, target, target_type, features, budget_hours, created_at, explore)
                  VALUES(model_name, target, target_type, features, budget_hours, created_at, explore)
      ;;

                sql_step: CREATE OR REPLACE VIEW @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_evaluate_{{ _explore._name }}
                    AS
                    {% if census_income_predictions_automl_training_data.select_target_type._parameter_value == 'numerical' %}
                       SELECT mean_absolute_error
                          , mean_squared_error
                          , mean_squared_log_error
                          , median_absolute_error
                          , r2_score
                          , explained_variance
                          , NULL AS precision
                          , NULL AS recall
                          , NULL AS accuracy
                          , NULL AS f1_score
                          , NULL AS log_loss
                          , NULL AS roc_auc
                        FROM ML.EVALUATE(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model_{{ _explore._name }})
                    {% elsif census_income_predictions_automl_training_data.select_target_type._parameter_value == 'categorical' %}
                        SELECT NULL AS mean_absolute_error
                          , NULL AS mean_squared_error
                          , NULL AS mean_squared_log_error
                          , NULL AS median_absolute_error
                          , NULL AS r2_score
                          , NULL AS explained_variance
                          , precision
                          , recall
                          , accuracy
                          , f1_score
                          , log_loss
                          , roc_auc
                        FROM ML.EVALUATE(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model_{{ _explore._name }})
                    {% endif %}
      ;;
              }
            }


          }
