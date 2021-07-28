# ReadMe for LookML Developers


## About this LookML Block

AutoML Tables uses AI to complete the data prep, feature engineering, model selection and hyperparameter tuning steps of a data
science workflow. It allows your entire team to automatically build and deploy state-of-the-art machine learning models on
structured data to predict numerical or categorical outcomes. Using this Block, Looker developers can add these advanced analytical
capabilities right into new or existing Explores, no data scientists required.

Using this Block, you can integrate Looker with BigQuery ML and AutoML Tables to get the benefit of advanced analytics without
needing to be an expert in data science. Start with your problem: What is the outcome you want to achieve? What kind of data is
the target column? Depending on your answers, this Block will create an auto-classification or auto-regression model to solve your
use case:

- A binary classification model predicts a binary outcome (one of two classes). Use this for yes or no questions, for example, predicting whether a customer will make a purchase.
- A multi-class classification model predicts one class from three or more discrete classes. Use this to categorize things, like segmenting defect types in a manufacturing process.
- A regression model predicts a continuous value. Use this to predict customer spend or future return rates.

This Block gives business users the ability to make predictions (categorical or numerical) from a new or existing Explore.
Explores created with this Block can be used to create multiple classification and regression models, evaluate them, and access
their predictions in dashboards or custom analyses.


## Block Requirements

This Block requires a BigQuery database connection with the following:
- Service account with the **BigQuery Data Editor** and **BigQuery Job User** predefined roles
- PDTs enabled
- The Looker PDT dataset must be located in the `US` multi-region location to use this block's example Explores


## Implementation Steps

1. Install block from Looker Marketplace
  - Specify the name of a BigQuery connection and the connection's dataset for Looker PDTs
2. Create an IDE folder to save refinements for each new use case
3. Create refinements of the following LookML files in the use case's IDE folder:
  -  (REQUIRED) `input_data.view` - Include the sql definition for the input dataset. The dataset should include data to be used for training as well as records that will be used to make predictions.
  -  (REQUIRED) `automl_predict.view` - Define the primary key dimension from `input_data.view` that will be used to join the predictions back to the input data.
  -  (RECOMMENDED) `model_name_suggestions.explore` - Add a *sql_always_where* clause to specify the `${model_info.explore} = explore_name`. This will prevent suggestions of ML models names created with other Explores.
4. Create a new LookML model for each use case
5. Add include statements to include `automl_tables.explore` file and all refinement files in your use case IDE folder
6. Create an Explore in the use case's LookML model that extends the `automl_tables` Explore
7. Join `automl_predict` to the extending Explore (*type: full_outer*) and define the JOIN criteria between `input_data` and `automl_predict`. (See [Example](/projects/automl_tables_block/files/models/census_income_predictions.model.lkml))


## Enabling Business Users

This block comes with a [Quick Start Guide for Business Users](/projects/automl_tables_block/documents/QUICK_START_GUIDE.md) and two example Explores.
- AutoML Tables: Census Income Predictions
- AutoML Tables: NYC Taxi Predictions


## Notes and Other Known Issues

BigQuery ML requires the target dataset for storing ML models be in the same location as the data used to
train the model. This block's example Explores use BiqQuery public data stored in the `US` multi-region location.
Therefore, to use the block's example Explores, your BiqQuery database connection must have a dataset for Looker
PDTs located in the `US` region. If you would like to use the block with data stored in other regions, simply
create another BigQuery connection in Looker with a Looker PDT dataset located in that region.

When using multiple BigQuery database connections with this block, it's recommended to use the same dataset
name for Looker PDTs in different BigQuery projects. This will prevent Looker PDT dataset references throughout
the block from breaking.
See [BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations) for more details.

Avoid using BigQuery analytic functions such as ROW_NUMBER() OVER() in the SQL definition of a use case's input data. Including
analytic functions may cause BigQuery to return an InternalError code when used with BigQuery ML functions. If your input data is
missing a primary key, CONCAT(*field_1, field_2, ...*) two or more columns to generate a unique ID instead of using ROW_NUMBER() OVER().


## Resources

[AutoML Tables Beginner's Guide](https://cloud.google.com/automl-tables/docs/beginners-guide)

[BigQuery ML Documentation](https://cloud.google.com/bigquery-ml/docs)

[BigQuery ML Pricing](https://cloud.google.com/bigquery-ml/pricing#bqml)

[BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations)


### Find an error or have suggestions for improvements?
Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommendations, simply create a "New Issue" in the corresponding Github repo for this Block. Please be as detailed as possible in your explanation, and we'll address it as quickly as we can.


#### Author: Chris Schmidt
