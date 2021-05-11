## About this LookML Block

Use this block to design user-friendly Looker Explores that allow business users to build and evaluate regression and classification machine learning models from the Looker UI.


## Implementation

1. Install block from Looker Marketplace
2. Update the database connection and looker temporary dataset constants in the manifest
3. Create a subfolder in the *use_case_refinements* IDE folder for your use case
4. Create a refinement of the *input_data* View for your use case
5. Create a model for your use case
6. Create an Explore in your new use case model that extends the *automl_tables* Explore
7. Define the JOIN between your input data and predictions in the extending Explore


## Resources

[AutoML Tables Docs: Beginner's Guide]
(https://cloud.google.com/automl-tables/docs/beginners-guide)

[BigQuery ML Docs: The CREATE MODEL statement for training AutoML Tables models]
(https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-create-automl#create_model_statement_for_automl_tables_models)



##### Author: Chris Schmidt
