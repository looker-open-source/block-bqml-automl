# **Quick Start Guide for Business Users**

## Creating and Evaluating Classification and Regression Models

AutoML Tables in BigQuery ML enables you to automatically build and deploy state-of-the-art machine learning models on structured data much faster (and often more accurately) than you could manually. All you have to do is provide AutoML an input dataset with an identified target (what you are trying to predict) and set of metrics to use for prediction. AutoML does all the heavy lifting that would normally take an analyst days or weeks to do such as:

* preprocesses the data
* performs automatic feature engineering
* model architecture search
* model tuning
* cross validation
* automatic model selection and ensembling

This Looker AutoML Block brings this advanced machine learning capability to the Looker Analyst with a step-by-step workflow to guide you through the model creation and evaluation process. Once a LookML Developer defines an Explore to support a specific use case and dataset, a Looker business analyst can begin building and evaluating models designed for classification or prediction.

AutoML Tables can be used for a variety of solutions. What is the outcome you want to achieve? What kind of data is the target column? The table below illustrates common problems, their ultimate objective and the best model type to use for them:

| example use cases | objective | model type |
| -------- | -------- | ---------- |
| Will a customer make a return visit? <br>Will a customer buy a particular product? <br>Is this transaction fraudulent? | With each of these examples, you are trying to predict a binary outcome (one of two possible outcomes–like yes or no) | binary classification model
| Is this review positive, negative or neutral? <br>Should I buy, sell or hold this stock? <br>Will my new customer's lifetime value be premier, high, medium or low? | With these, you are trying to predict more than two classes or outcomes. | multi-class classification model |
| What should the insurance premium be for this customer? <br>How much sales will this new location generate in the first year? | In these use cases, the objective is to predict a continuous value. | linear regression model |

This Quick Start Guide will outline how a business analyst can create and evaluate classification and regression models within Looker. An Explore defined with BQML AutoML will include steps to **create a model** and steps to **evaluate a model**. We will describe these steps at a high-level and then discuss each step in more detail as we walk through the example Explore **AutoML Tables: Census Income Predictions** included with the block.

>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i> Note, Models created by AutoML Tables can take hours to run. </font></b>As noted earlier, AutoML Tables handles many tasks to create a model including pre-processing data, hyper-parameter tuning, and model validation. Since this can take more than an hour to run, you should set up the required parameters for defining the model (name, target, features, etc...) and then use **SEND** (rather than RUN) to create the model asynchronously via Looker Scheduler. You will receive an email when the model is complete and can return to the Explore to review the results.
>

### Create Model Steps

To create a model, you must review and make selections from *Steps 1 - 5*. You may also select from *Steps 6 - 8* when creating a model; however, these steps are not required to create the model.

| Step  | Description |
| ------------- | ------------- |
| **\[1\] AutoML: Input Data**  | Data to be used for training a model and/or generating predictions. |
| **\[2\] AutoML: Name Your Model** | **REQUIRED** Name of model to be created or evaluated (no spaces allowed).  |
| **\[3\] AutoML: Select Training Data**  | **REQUIRED to create model** Provide `target type` (numerical or categorical), `target` (the known outcome you are trying to predict) and `features` (what fields do you want to use to predict the target outcome). Features available for selection come from the list of dimensions found in Input Data (*Step 1*).  |
| **\[4\] AutoML: Set Model Parameters**  | Set the training budget for AutoML Tables training, specified in hours. Defaults to 1.0 and must be between 1.0 and 72.0. |
| **\[5\] AutoML: Create Model via SEND email**  | **REQUIRED to create model** To create a model, you must add this dimension to the query and SEND the query results via email (rather than RUN). When a model has successfully completed, you will receive an email with results showing "Complete".  |

### Evaluate Model Steps

To evaluate a model which has already been created, you must specify name of the model (*Step 2*) plus make selections from *Steps 6, 7, and/or 8*. You may also select from the Input Data (*Step 1*) for analysis if needed.

| Step  | Description |
| ------------- | ------------- |
| **\[6\] AutoML: Evaluation Metrics**  | Review accuracy of the model predictions. Note, if the model has target type of **Categorical**, you will review the evaluation metrics shown under the `Metrics for Models with Categorical Targets` group such as **Accuracy**, **Precision**, and **Recall**. If the model's target type is **Numerical**, you will review the evaluation metrics shown under `Metrics for Models with Numerical Targets` such as **R Squared (R^2)** and **Mean Squared Error**.  |
| **\[7\] AutoML: Predictions** | Review predicted outcomes based on the model.  |
| **\[8\] AutoML: Feature Info** | See information about the input features used to train a model such as min, max, average for numeric features.   |

# TUTORIAL: Classification Model

The proper preparation of the input dataset is critical to the success of any model. The LookML developer who sets up the AutoML Tables Explore will need to prepare a dataset to support supervised learning. Supervised learning is a machine learning approach where datasets with known outcomes (called labels) are used to train the model algorithm to predict outcomes accurately.

For example, a retailer may want to predict whether a given customer will purchase a new product, based on other information about that customer. In that case, the two labels might be `will buy` and `won't buy`. You can construct your dataset such that one column represents the label. The data you can use to train such a classification model include the customer's location, previous purchases, the customer's reported preferences, and so on.

In this tutorial, you will use Looker + AutoML to create a model that predicts whether a US Census respondent's income falls into one of two ranges based on the respondent's demographic attributes.

## **\[1\] AutoML: Input Data**

You begin with the Explore **AutoML Tables: Census Income Predictions** which is included with this block (you should be able to find it in your Explore menu or searching for the name). Our goal is to predict how likely a person is to be in one of two income ranges. The input dataset has already been defined and can be reviewed in step **\[1\] AutoML: Input Data**. The target in the training data is `Income Bracket` with two possible labels: **> $50K** or **<=$50K**.

Several demographic attributes such as age, marital status, education level, occupation are included and can be used as inputs or features of the model to create the prediction. You'll choose the features to include in the model in **\[3\] AutoML: Select Training Data**.

AutoML Tables preprocesses the data and performs automatic feature engineering for you– including transformations, variable encoding, missing value imputation, and splitting into train/validation datasets. The input data to AutoML Tables must be between 1,000 and 100 million rows and less than 100 GB.


>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i> Note, all rows of the input dataset are used in training the model regardless of filters. </font></b> You can filter the input dataset as necessary to review and understand your data or to build visualizations; however, for modeling purposes **all** rows of the input dataset are included when creating an AutoML Tables model. If you need to alter the input dataset (e.g., add or remove metrics), contact a LookML Developer for assistance in refining the Explore to meet your use case.
>



## **\[2\] AutoML: Name Your Model**  (*REQUIRED*)

For the required filter-only field **BQML Model Name (REQUIRED)**, enter a unique name to create a new BQML model or select an existing model to use in your analysis. Name must not include spaces. Note, if you enter a model name which already exists and send a query with  **Train Model (REQUIRED)** dimension to the Looker Scheduler, the existing model will be replaced. Clicking into the filter will generate a list of existing models created for the given Explore if any.

  > For the **Census Income Predictions** example, enter unique name (e.g. predict\_income)


## **\[3\] AutoML: Select Training Data**  (*REQUIRED to create model*)
Expand the section in the field picker and add each these required paramaters to the filter pane:

| required parameter | description | tutorial example |
| -------- | -------- | ---------- |
| **Select a Target (REQUIRED)** | Select one dimension you are trying to predict | choose **Income Bracket** |
| **Select Features (REQUIRED)** | Select one or more dimensions to include in the model as predictors of the target. Be sure to select meaningful features as predictors. Fields with random values like ID fields should be avoided. | select `age`, `education`,`marital status` and `occupation` from the dropdown list. |
| **Select Target Type (REQUIRED)** | Select Categorical or Numerical. Note, even in use cases where your target labels are a numeric value (e.g., 1 or 0), these labels represent categories ('yes' or 'no') so you would select Categorical. | With the goal to predict one of two income brackets, select `Categorical`. |

## **\[4\] AutoML: Set Model Parameters**

An AutoML model executed by BigQuery is trained on the AutoML Tables backend and incurs different costs than other machine learning queries. To set the maximum number of training hours for the model, add **Set Budget Hours (optional)** to the filter pane and enter the desired value.  The value can range from 1 to 72 hours and reflects the maximum amount of training time you will be charged for. By default, the value is set to 1.

Suggested training time is related to the size of your training data. The table below shows suggested training time ranges by row count; a large number of features/columns will also increase training time.

| Rows | Suggested training time |
| --------- | --------- |
| Less than 100,000 | 1-3 hours |
| 100,000 - 1,000,000 | 1-6 hours |
| 1,000,000 - 10,000,000 | 1-12 hours |
| More than 10,000,000 | 3 - 24 hours |

Model creation includes other tasks besides training, so the total time it takes to create your model is longer than the training time. For example, if you specify 2 training hours, it could still take 3 or more hours before the model is ready. You are charged only for actual training time.

If AutoML Tables detects that the model is no longer improving before the training budget is exhausted, it stops training.


## **\[5\] AutoML: Create Model via SEND email** (*REQUIRED to create model*)

To submit any query in Looker, you must include at least one dimension in the data pane. Due to the lengthy processing time required for AutoML models, you will use the SEND option to execute the query asynchronously via Looker Scheduler and deliver the result via email. Follow these steps:

>
>1. Add the **Train Model (REQUIRED)** dimension to the data pane.
2. Click `Gear` menu next to the Run button and select `Send`.
3. Add title (or use the default title).
4. Select `Email` in **Where should data go** section
5. Confirm or add `Email Address` in **Who should it be emailed to?** section
6. Select `Data Table` in **Format data as** section
7. Click `SEND`
>

Training a model can take several hours to complete depending on the size of the dataset and the training budget hours. You can continue using Looker for data exploration or close your browser window without affecting the training process. The query will execute via Looker Scheduler Jobs and the result will be emailed. You will receive an email with `Complete` in the message body if the model is generated successfully or with an error message if the model fails for any reason.

If you select a model name which already exists, the model will be replaced with the latest iteration of the model creation step. After submitting the model to be created, you should remove the **Train Model (REQUIRED)** dimension from the data pane to avoid inadvertently creating the model again.


## **\[6\] AutoML: Evaluation Metrics** – Classification Models

Once you receive notification the model is complete, you can return to the AutoML Explore, enter the model name and continue with model evaluation and/or prediction steps.

When you expand **\[6\] AutoML: Evaluation Metrics** in the field picker you will see two groups of metrics available. Only one set of metrics is populated depending on the `Target Type` value set for the model.

| Target Type | Evaluation Metrics Group |
| --------- | --------- |
| Categorical |  **Metrics for Models with Categorical Targets** |
| Numerical | **Metrics for Models with Numerical Targets** |

Continuing with the Tutorial example **Census Income Predictions**, you set the `Target Type` to **Categorical**. Your two labels are income **> $50K** or **<= $50K**. As we cover the concepts of evaluation metrics, we will treat the label **> $50K** as our *positive* class and **<= $50K** as our *negative* class.

A binary classification model produces a probability between 0 and 1 that the observation belongs to each class. An observation's predicted label is where probability exceeds a threshold of 0.50. To determine `accuracy` of the model, you could simply look at the fraction of the predictions which are correct. But `accuracy` alone may not be a good indicator of how well the model makes predictions. The `confusion matrix`, `precision`, `recall`, and `F1 score` metrics can give additional insight.

A confusion matrix is a table with predicted values on one side and actual values on the other like below.

|    | Predicted Positive (> $50k) | Predicted Negative (<= $50k) | |
| --------- | --------- | --------- |
| **Actual Positive (> 50)** | _True Positive_ | False Negative |
| **Actual Negative (<= 50)** | False Positive | _True Negative_ |

A `True Positive` is when the model correctly predicts the positive class (both prediction and actual are both positive). A `True Negative` is when the model correctly predicts the negative class (both prediction and actual are both negative).

A `False Positive` is when the model predicts the positive class when it is actually the negative class. A `False Negative` is when the model predicts the negative class when it is actually the positive class.

`Precision` is the fraction of predicted positives that are actual positives (true positives / true positives + false positives). In other words, it is a way of saying “given I’ve predicted this to be true, what is the probability that I’m right?”

`Recall` is the true positive rate – the fraction of actual positives that are predicted positives (true positives / true positives + false negatives).

Determining if the model is good is often a balance between `Precision` and `Recall`. Consider a use case where you are trying to predict fraud. It is very important to find as many Fraud cases as possible so you want to minimize the false negatives and maximize Recall value.

Now consider a use case where you are trying to predict if an email is spam. What if you predict a critical email to be spam when it is not (false positive)? In this situation it is more important to minimize false positives; therefore, a higher `Precision` value is desired.

 The `F1 Score` is a single metric combining precision and recall value and takes into account both false negatives and false positives.

Below are the full set of evaluation metrics available for classification models and the results for the **Census Income Predictions** model (note your results may not match exactly).

| Categorical Target Evaluation Metric  | Description | Example Results for **Census Income Predictions** model |
| ------------- | ------------- |
| **Accuracy** | The fraction of classification predictions produced by the model that were correct. | 0.87 |
| **F1 Score** | The harmonic mean of precision and recall. F1 is a useful metric if you're looking for a balance between precision and recall and there's an uneven class distribution. | 0.66 |
| **Log Loss** | Loss increases as the predicted probability diverges from the actual label. A lower log loss value indicates a higher-quality model. | 0.75 |
| **Precision** | The fraction of positive predictions produced by the model that were correct. Positive predictions are the false positives and the true positives combined. | 0.67 |
| **Recall** | True Positive Rate: The fraction of rows with this label that the model correctly predicted. | 0.65 |
| **ROC AUC** | The area under the receiver operating characteristic (ROC) curve. This ranges from zero to one, where a higher value indicates a higher-quality model. | 0.79 |

This example model does produce reasonable results. If you are not satisfied with the results, you could consider including additional features or increasing the model training hours.

For information on the evaluation metrics for Numeric Predictions (linear regression models), see section **Evaluation Steps: Regression Model** following this tutorial.


## **\[7\] AutoML: Predictions** - Classification Models

Now that the model is created you can apply it and produce predictions for the full input dataset. Note, you may also have your LookML Developer set up an additional Explore that generates predictions for an entirely new dataset.

The classification model produces a predicted label/class for each observation in the input data set. You could look at each prediction or create a summary of predictions. Let's walk through an example comparing the actual income bracket versus the predicted income bracket.

To build a new visualization for the **Census Income Predictions** example:

> 1. From the explore, expand the `filters` pane and enter the name of the model created in **\[2\] AutoML: Name Your Model**
2. From the field picker expand folder **\[7\] AutoML: Predictions**, add `Category Prediction` to the data pane.
3. Add `Count of Predictions` to the data pane.
4. Expand folder **\[1\] AutoML: Input Data** and add `Income Bracket` to the data pane as a **PIVOT** column.
5. In the Data pane header, check Totals and Row Totals.
6. Click `RUN` to see how well the model predicted the income brackets "> $50K" and "<= $50K".

This table is like the `Confusion Matrix`. You could compute the `Precision`, `Recall` and other metrics reviewed earlier but note you may get slightly different results. The evaluation metrics in *Step 6* were computed against an evaluation dataset which is a random subset of the Input Data *Step 1*. The values here are generated from predictions against the entire dataset.

## **\[8\] AutoML: Feature Info**

This step allows you to see summary information about the input features used to train a model.

| Dimension  | Description |
| ------------- | ------------- |
| input | The name of the column in the input training data. |
| min | The sample minimum. This column is NULL for non-numeric inputs. |
| max | The sample maximum. This column is NULL for non-numeric inputs. |
| mean | The average. This column is NULL for non-numeric inputs. |
| stddev | The standard deviation. This column is NULL for non-numeric inputs. |
| category_count | The number of categories. This column is NULL for non-categorical columns. |
| null_count | The number of NULLs. |

# Evaluation Steps: Regression Model
The steps to submit a model (*Steps 1 - 5* of the Explore workflow) are the same regardless of the type of model being created–whether you are trying to predict a categorical value (like yes/no) or a continuous numerical value (like total sales).

Because the machine learning approaches differ–-logistic regression is used for categorical predictions and linear regression is used for continuous value prediction–the methods of evaluating the effectiveness of the model differ. In the tutorial outlined in the previous section, the focus was logistic regression and categorical values. In this section, we'll look at Evaluation  and Prediction steps specifically for linear regression models.

## **\[6\] AutoML: Evaluation Metrics** – Linear Regression Models

The evaluation metrics for models with `Target Type` of **Numerical** (linear regression models) are found in the group **Metrics for Models with Numerical Targets**.

| Numerical Target Evaluation Metric  | Description |
| ------------- | ------------- |
| **Explained Variance** | The portion of the model’s total variance that is explained by factors that are actually present and isn’t due to error variance. Higher percentages of explained variance indicate better predictions. |
| **Mean Absolute Error** | The mean absolute error (MAE) is the average absolute difference between the target values and the predicted values. Not preferred in cases where outliers are prominent. This metric ranges from zero to infinity; a lower value indicates a higher quality model.  |
| **Mean Squared Error** | The average of the squared differences between the target values and the predicted values. Commonly used as it penalizes large errors. This metric ranges from zero to infinity; a lower value indicates a higher quality model. |
| **Mean Squared Log Error** | Similar to mean squared error, except that it uses the natural logarithm of the predicted and actual values plus 1. This metric penalizes under-prediction more heavily than over-prediction. It can also be a good metric when you don't want to penalize differences for large prediction values more heavily than for small prediction values. This metric ranges from zero to infinity; a lower value indicates a higher quality model. The metric is returned only if all labels and predicted values are non-negative. |
| **Median Absolute Error** | The median of the absolute difference between the target value and the value predicted by the model. Is insensitive to outliers. This metric ranges from zero to infinity; a lower value indicates a higher quality model. |
| **R Squared** | R squared (r^2) or Coefficient of Determination represents the part of the variance of the target variable explained by the feature variables of the model. This metric ranges between zero and one; a higher value indicates a higher quality model. |

The more common evaluation metrics used to determine how good a model performs are `Mean Squared Error` and `R Squared`. For regression models created by this block the optimization objective is to minimize the `Mean Squared Error` and a lower value indicates a better performing model . `R Squared` indicates goodness of fit so values close to 1 indicate smaller differences between the known values and predicted values.

## **\[7\] AutoML: Predictions** - Regression Models

A regression model produces a predicted value for each observation in the input data set which is shown with the `Numeric Prediction` dimension. You can also compute aggregated measures for the prediction using `Total Prediction` and `Average Prediction` found in the **Measures for Numeric Predictions** group.


# Customizations
>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i> Note, AutoML Explores can be customized to include additional model types, options and parameters. </font></b> If you would like to use a different machine learning model type or control other model parameters like modeling objective, training/validation sets, or target probability thresholds, contact your Looker Developer or Looker Professional Services to customize an Explore to meet your needs.
>


## Resources

[BigQuery ML Documentation](https://cloud.google.com/bigquery-ml/docs)
[BigQuery ML Pricing](https://cloud.google.com/bigquery-ml/pricing)

#### Author: Google
