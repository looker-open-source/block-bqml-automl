view: automl_create_model {
  derived_table: {
    persist_for: "1 second"

    create_process: {

      sql_step: CREATE OR REPLACE MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_model_{{ _explore._name }}
                  OPTIONS(
                    {% if automl_training_data.select_target_type._parameter_value == 'numerical' %}
                      MODEL_TYPE = 'AUTOML_REGRESSOR'
                    {% elsif automl_training_data.select_target_type._parameter_value == 'categorical' %}
                      MODEL_TYPE = 'AUTOML_CLASSIFIER'
                    {% endif %}
                    , INPUT_LABEL_COLS = ['input_label_col']
                    , BUDGET_HOURS = {% parameter set_budget_hours %}
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
                      '{% parameter automl_training_data.select_target %}' AS target,
                      '{% parameter automl_training_data.select_target_type %}' AS target_type,
                      {% assign features = _filters['automl_training_data.select_features'] | sql_quote | remove: '"' | remove: "'" %}
                        '{{ features }}' AS features,
                      {% parameter set_budget_hours %} AS budget_hours,
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
                      , explore=S.explore
                WHEN NOT MATCHED THEN
                  INSERT (model_name, target, target_type, features, budget_hours, created_at, explore)
                  VALUES(model_name, target, target_type, features, budget_hours, created_at, explore)
      ;;

      sql_step: CREATE OR REPLACE VIEW @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_automl_evaluate_{{ _explore._name }}
                    AS
                    {% if automl_training_data.select_target_type._parameter_value == 'numerical' %}
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
                    {% elsif automl_training_data.select_target_type._parameter_value == 'categorical' %}
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

  parameter: set_budget_hours {
    view_label: "[4] AutoML: Set Model Parameters"
    label: "Set Budget Hours (optional)"
    description: "Sets the training budget for AutoML Tables training, specified in hours. Defaults to 1.0 and must be between 1.0 and 72.0."
    type: number
    default_value: "1.0"
  }

  dimension: train_model {
    view_label: "[5] AutoML: Create Model"
    label: "Train Model (REQUIRED) IMPORTANT: READ DESCRIPTION"
    description: "Select this field and SEND the query to yourself via Email to start training your model. Do not attempt to Run a query in the browser with this field selected. If you do, your query will timeout before the AutoML model is created."
    type: string
    sql: 'Complete' ;;
  }
}
