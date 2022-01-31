# ReadMe for LookML Developers


## About this LookML Block

AutoML Tables uses AI to complete the data prep, feature engineering, model selection and hyperparameter tuning steps of a data science workflow. It allows your entire team to automatically build and deploy state-of-the-art machine learning models on structured data to predict numerical or categorical outcomes. Using this Block, Looker developers can add these capabilities into new or existing Explores and allow business users to benefit from advanced analytics without needing to be an expert in data science.

To integrate Looker with BigQuery ML and AutoML Tables start with your problem: What is the outcome you want to achieve? What kind of data is the target column? Depending on your answers, this Block will create an auto-classification or auto-regression model to solve your use case:

| model | predicts | example use case |
| -------- | -------- | ---------- |
| binary classification model | binary outcome (one of two classes) | use for yes or no questions (e.g. will customer make a purchase)|
| multi-class classification model | one class from three or more discrete classes | categorize things like segmenting defect types in a manufacturing process |
| regression model | continuous value | customer spend or future return rates |

This Block gives business users the ability to make predictions (categorical or numerical) from a new or existing Explore. Explores created with this Block can be used to create classification and regression models, evaluate them, and access their predictions in dashboards or custom analyses.

Models created by AutoML Tables can take hours to run; therefore, users should set up the required parameters for defining the model (name, target, features, etc...) and then use SEND (rather than RUN) to create the model asynchronously via Looker Scheduler. When the model is complete, the user will receive an email and can return to the explore to review the results. Note any user of these AutoML explores will need `schedule_look_emails` permission (see [Content Delivery Permissions](https://docs.looker.com/sharing-and-publishing/scheduling-and-sharing/scheduling-for-admins)).

---
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i>  Reach out to your Looker account team if you would like to partner with Looker Professional Services to implement this Looker + BQML block or customize for your specific use case</font></b>

---

## Block Requirements
### 1. An existing [BigQuery database connection](https://docs.looker.com/setup-and-management/database-config/google-bigquery#overview):
- using **Service Account** with the `BigQuery Data Editor` and `BigQuery Job User` predefined roles. Note a connection using BigQuery OAuth cannot be used as Persistent Derived Tables are not allowed.

- with **Persistent Derived Tables** (PDTs) enabled

### 2. **BigQuery Dataset for storing AutoML model details and related tables**
- This dataset could be the same one named in your connection for Looker PDTs but does not have to be. The Service Account named in your Looker data connection must have read/write access to the dataset you choose.

- The dataset must be located in the same multi-region location as your use case data defined in the Explore (see note below). This Block creates multiple tables and views in this dataset.

During installation you will be asked for the connection and dataset name. These values will be added as constants to the Block's project marketplace_lock file. These constants will be referenced throughout the Block as AUTO ML models are created.

---
 <font size = "3"><font color = "red"> <i class='fa fa-exclamation-triangle'></i><b> note:  BigQuery ML processes and stages data in the same location.</b></font></font><br> See [BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations) for more details. The example Explore included in this Block is based on BigQuery public dataset stored in the `US` multi-region location. Therefore, to use the Block’s example Explore you should name a dataset also located in the `US` multi-region. To use this Block with data stored in region or multi-region outside of the `US`, name an AutoML model dataset located in the same region or multi-region and use refinements to hide the example Explore as it will not work in regions outside of the `US`.


 <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note: This Block is intended to be used with only one data connection and one dataset for model processing.</b></font></font><br>If you would like to use Block with multiple data connections, customization of the Block is required. Reach out to your Looker account team for more information and guidance from Looker Professional Services.

---


## Installation Steps
1. From the Looker Marketplace page for [BigQuery ML Classification and Regression (AutoML Tables) block](/marketplace/view/bqml-automl), click `INSTALL` button
2. Review **license agreement** and click `Accept`
3. Review **required Looker permissions** and click `Accept`<br>_note these permissions allow Marketplace to install the Block and are not related to user or developer permissions on your instance_
4. Specify **configuration details**
    - Select **Connection Name** from the dropdown. This value will be saved to the Block's marketplace_lock file for the constant named `CONNECTION_NAME` and referenced throughout the Block.
    - Enter **name of dataset for storing Model details and related tables**. This value can be the same dataset used for Looker PDTs as defined in the selected connection. This value will be saved to the Block's marketplace_lock file for the constant `looker_temp_dataset_name` and referenced throughout the Block.

Upon successful completion of the installation, a green Check Mark and bar will appear. These new objects are installed:

| type | name | description |
| -------- | -------- | ---------- |
| project | marketplace_bqml-automl |
| explore | AutoML Tables: Census Income Predictions | found in Explore menu under Looker + BigQuery ML |
| explore | AutoML Tables: Model Info  | found in Explore menu under Looker + BigQuery ML; captures details for each AutoML model created with this Block |

---
 <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note:  The marketplace_bqml-automl project is installed as a bare GIT repository.</b></font></font><br>For version control utilizing a remote repository, you will need to [update the connection settings for your Git repository](https://docs.looker.com/data-modeling/getting-started/setting-up-git-connection).

---

At this point you can begin creating your own Explores incorporating the AutoML model workflow (see next section for details on building your own Explores) or navigate to the included explore example and create a classification or regression model.

## Building an Explore with the AutoML Block

The installed Block provides a workflow template as part of an Explore to guide a business user through the steps necessary to create and evaluate AutoML models. As seen in the provided Explore `AutoML Tables: Census Income Predictions`, a user navigates through a series of steps to create and evaluate classification or regression models. These are the workflow steps for an AutoML model:
> <b>[1] AutoML: Input Data<br>
> [2] AutoML: Name Your Model<br>
> [3] AutoML: Select Training Data<br>
> [4] AutoML: Set Model Parameters<br>
> [5] AutoML: Create Model via SEND email<br>
> [6] AutoML: Evaluation Metrics<br>
> [7] AutoML: Predictions<br>
> [8] AutoML: Feature Info</b>

For each use case, a LookML developer will create an Explore incorporating the workflow template by changing the Input Data to match a specific use case. For example, your use case may be a classification model to predict a customer’s likelihood to purchase a new product. You would add a new model and explore to the `marketplace_bqml-automl project` extending the AutoML explore that defines the overall workflow and modifying the input data to capture the desired target and feature data (i.e., the data needed to train the model).

At a high-level the steps for each use case are:
><b>1)  Create Folder for all Use Case files<br>
>2)  Add New Model <br>
>3)  Make Refinements of select Explores and Views <br>
>4)  Add New Explore which Extends the Block's AutoML Explore <br></b>

Details and code examples for each step are provided next. Note, all steps take place in `marketplace_bqml-automl` project while in **development mode**.

---
 <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note:  If copying/pasting example LookML from this document, ensure quotation marks are straight quotes (") </b></font></font><br>When pasting from this document, quotations may appear as curly or smart quotes (“). If necessary, re-type quotes in the LookML IDE to change to straight quotes.

---


### 1. Create Folder for all Use Case files (one folder per use case)
When you open the `marketplace_bqml-automl` project while in development mode and review the `File Browser` pane, you will see the project contains a folder called `imported_projects`. Expanding this folder you will see a subfolder named `bqml-automl`. This folder contains all the models, explores and views for the Block. These files are read-only; however, we will be including these files in the use case model and refining/extending a select few files to support the use case. You should keep all files related to the use case in a single folder. Doing so will allow easy editing of a use case. Within the project, you should create a separate folder for each use case.

| steps | example |
| -- | -- |
| Add the folder at the project's root level by clicking + at the top of `File Browser` | |
| Select Create Folder | |
| In the Create File pop-up, enter a `Name` for the use case folder<br> Note, you should use also use this same name for the Model and Explore created in next steps | ga_repeat_visitor |
| Click `CREATE` |

### 2. Add New Model
Add a new model file for the use case, update the connection, and add include statements for the Block's AutoML_Tables Explore and use case refinement files. The included Explore from the Block will be extended into the use case Explore which will be created in the next step.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder created in prior step | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create Model | |
| In the Create File pop-up, enter a `Name` for the use case folder  | ga_repeat_visitor |
| Click `CREATE` |
| Within newly created model file, set `connection:` parameter to match value set during installation of this Block | connection: "thelook_bq" |
| Add an include statement for all view files found in same directory (note, you may receive a warning files cannot be found but you can ignore as files will be added in following steps)| include: "*.view" |
| Add an include statement for all Explore files found in same directory (note, you may receive a warning files cannot be found but you can ignore as files will be added in following steps) | include: "*.explore" |
| Add an include statement for the Block's `automl_tables.explore` so the file is available to this use case model and can be extended into the new Explore created in the next step.| include: "//bqml-automl/**/automl_tables.explore" |
| Click `SAVE` | |


### 3. Make Refinements of select Explores and Views from the Block
Just like we used the automl_tables explore as a building block for the use case explore, we will adapt the Block's `input_data.view`, `model_name_suggestions.explore` and `automl_predict.view` for the use case using LookML refinements syntax. To create a refinement you add a plus sign (+) in front of the name to indicate that it's a refinement of an existing view. All the parameters of the existing view will be used and select parameters can be modified (i.e., overwrite the original value). For detailed explanation of refinements, refer to the [LookML refinements](https://docs.looker.com/data-modeling/learning-lookml/refinements) documentation page. Within the use case folder, add a new `input_data.view`, a new `model_name_suggestions.explore` and a new `automl_predict.view`. Keep reading for detailed steps for each refinement file.


#### <font size=5>3a. input_data.view </font><font color='red'> (REQUIRED)

The input_data.view is where you define the data to use as input into the model. The input data to AutoML Tables must be between 1,000 and 100 million rows, and less than 100 GB. The Block's example input_data.view is a SQL derived table, so the use case refinement will update the derived_table syntax and all dimensions and measures to match the use case. We recommend using SQL Runner to test your query and generate the Derived Table syntax (see [SQL Runner](https://docs.looker.com/data-modeling/learning-lookml/sql-runner-create-dts) documentation for more information). The steps are below.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create View | |
| In the Create File pop-up, enter `input_data` <br><br>While this file name does not have to match the original filename, we recommend you keep it the same.| input_data |
| Click `CREATE` |
| Navigate to SQL Runner by clicking on the `Develop` Menu and selecting `SQL Runner` | |
| In left pane, change `Connection` to match the connection defined during installation of this Block (see project's marketplace_lock file and value for `@{CONNECTION_NAME}`)  | @CONNECTION_NAME = thelook_bq |
| Write and test your SQL query to produce the desired dataset. At minimum, the query must return a target field (outcome we are trying to predict) and one feature (fields used to make the prediction). The provided example creates a simple dataset with ga_session_id, ga_repeat_visitor, is_mobile,total_timeonsite, total_pageviews. | SELECT<br>ga_session_id<br>,CASE WHEN ga_sessions.visitnumber > 1  THEN 'Yes' ELSE 'No' END as ga_repeat_visitor<br>, is_mobiledevice<br>,sum(pageviews) as total_pageviews<br>, sum(timeonsite) as total_timeonsite<br>FROM ga_sessions<br>group by 1,2,3|
| Once the results are as expected, click the `gear` menu (next to the Run button) and select `Get Derived Table LookML`. | |
| Copy the generated LookML (all lines) | |
| Navigate back to `input_data.view` in your Use Case Folder | |
| Delete all the notes in the file which were auto-generated when you created the file | |
| Paste the contents from SQL Runner into the file | |
| On line 1 of the file insert include statement for the Block view to be refined | include: "//bqml-automl/views/input_data.view" |
| Replace `view: sql_runner_query` with `view: +input_data` <br> <br>The plus sign (+) indicates we are modifying/refining the original input_data view defined for the Block | view: +input_data |
| Review the remaining LookML and edit as necessary with:<br>a. names, labels, group labels, descriptions<br>b. identify the primary key field<br>c. Modify date formats as necessary. For example, dates are automatically defined as a `dimension_group with type of time` so modify as necessary for timeframes or convert to a single date dimension.<d> Add any additional measures if needed (only count created by default) | dimension: ga_session_id {<br>  type: string<br>  primary_key: yes<br>  sql: <br>${TABLE}.ga_session_id ;;<br>} |
| Click `SAVE` | |

---
   <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note: Avoid using BigQuery analytic functions such as ROW_NUMBER() OVER() in the SQL definition of a use case's input data.</b></font></font> Including analytic functions may cause BigQuery to return an `InternalError` code when used with BigQuery ML functions. If your input data is missing a primary key, CONCAT(*field_1, field_2, ...*) two or more columns to generate a unique ID instead of using ROW_NUMBER() OVER().

---

#### <font size=5>3b. model_name_suggestions.explore </font><font color='red'> (REQUIRED)
To create an AutoML model, the user must enter a name for the model and can type in any string value. The AutoML Explore also allows the user to evaluate a model which has already been created. The `Model Name` parameter allows users to select the name from a list of existing models created by the given Explore. These suggested values come from the `AUTOML_TABLES_MODEL_INFO` table stored in the Model Details dataset defined for the Block during installation. Because this table captures details for all models created with the Block across all Explores, we need to filter the suggestions by Explore name–the Explore which will be created in `Implementation Step 4`. If you do not filter for the use case Explore, an error would occur if the user tries to evaluate a model based on different input data.

The name suggestions come from the `model_name_suggestions.explore` and in this step we will refine the `sql_always_where` filter applied to the include the use case Explore name.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create Generic LookML File | |
| In the Create File pop-up, enter `model_name_suggestions.explore` <br><br>While this file name does not have to match the original filename, we recommend you keep it the same. Be sure to include the `.explore` extension so you can quickly identify the type from the File Browser. | model_name_suggestions.explore |
| Click `CREATE` |
| On line 1 of the blank file, insert include statement for the Block explore to be refined | include: "//bqml-automl/**/model_name_suggestions.explore" |
| On the next lines, enter<br> a. the explore name using the + refinement syntax<br> b. update sql_always_where syntax with use case explore name (as shown in <font color = 'orange'>bold</font> in the example) | explore: +model_name_suggestions {<br>  sql_always_where: ${model_info.explore} =<font color='orange'><b>'ga_repeat_visitor'</b></font>;;<br>} |


#### <font size=5>3c. automl_predict.view </font><font color='red'> (REQUIRED)
When generating the prediction for the input dataset, the resulting output includes the primary key of the dataset. For example, you may be generating a prediction for a customer or a session or other types of observations. Because the field name in the prediction output file can take on any value, a generic name is used instead. `input_data_primary_key`. To handle this you need to create a refinement of the automl_predict.view and specify the the *label:* and *sql:* parameters for the `input_data_primary_key` dimension. The *label:* and *sql:* parameters should match the primary key column from `input_data.view`. Note the label could be changed to reflect a more meaningful label the user will recognize.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create View | |
| In the Create File pop-up, enter `automl_predict` <br><br>While this file name does not have to match the original filename, we recommend you keep it the same.| automl_predict |
| Click `CREATE` |
| On line 1 of the file insert include statement for the Block view to be refined | include: "//bqml-automl/**/automl_predict.view" |
| Replace `view: automl_predict` with `view: +automl_predict` <br> <br>The plus sign (+) indicates we are modifying/refining the original automl_predict view defined for the Block | view: +automl_predict |
| On next lines, add dimension: input_data_primary_key and update the *label:* and *sql:* parameters accordingly:| dimension: input_data_primary_key {<br>    <font color='orange'><b>label: "GA Session ID"<br>    sql: ${TABLE}.ga_session_id;; </b></font><br>} |
| Click `SAVE`| |


### 4. Add New Explore which Extends the Block's AutoML Tables Explore
As noted earlier, all the files related to this Block are found in the `imported_projects\bqml-automl` directory. The Explore file `automl_tables.explore` specifies all the views and join relationships to generate the stepped workflow the user will navigate through to create and evaluate classification and/or regression models using AutoML. For each use case, you will use the `automl_tables` Explore as a starting point by extending it into a new Explore. The new Explore will build upon the content and settings from the original Explore and modify some of the components to fit the use case. See the [extends for Explores](https://docs.looker.com/reference/explore-params/extends) documentation page for more information on extends. In the previous step, we added the `include: "//bqml-automl/**/automl_tables.explore"` statement to the model file so that we could use this Explore for the use case. Below are the steps for adding a new Explore to the use case model file.

| steps | example                |
| -- | -- |
| Open the Use Case Model file | ga_repeat_visitor.model |
| Add Explore LookML which <br> a. includes label, group_label and/or description relevant to your use case<br>b. extends the automl_tables explore<br>c. updates the join parameter between `automl_predict` and `input_data` to reflect correct unit<br> <br>The AutoML model output generates a forecast for the target variable modeled and is named __input_data_primary_key__. <br>The target variable modeled could vary by use case (e.g., visitor, customer, machine), so need to update the Explore to capture the correct unit defined in the use case's `input_data` view file (as defined in the previous step).<br><br>In the example, edit the terms in <b><font color='orange'>bold</font></b> to fit your use case.<br> |explore: <font color='orange'><b>ga_repeat_visitor</b></font> {<br>  label: <font color='orange'><b>"AutoML: Google Analytics Repeat Visitor"</b></font><br>  description: <font color='orange'><b>"Use this Explore to create Classification or Regression models to make categorical or numerical predictions for Google Analytics data"</b></font><br><br>  extends: [automl_tables] <br><br>   join: automl_predict {<br>    type:full_outer<br>    relationship: one_to_one<br>    sql_on: <font color = 'orange'><b>${input_data.ga_session_id}</b></font> = ${automl_predict.input_data_primary_key} ;;<br>  }<br>} |
| Click `SAVE`| |


---
   <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note: When creating the AutoML model asynchronously, use production mode </b></font></font> As noted earlier, due to the lengthy processing times common with AutoML Tables, users should set the model parameters and SEND the model creation query via Looker Scheduler rather than choosing RUN. Explores can be sent as one-time deliveries only and reflect the production mode of LookML (not development mode). Therefore, when testing LookML changes for this project you should commit and push to production and exit development mode.

---


## AutoML Tables CREATE MODEL Syntax

With this block, the user will be able to control these options for the AutoML Tables Model:

| options | description | default |
| -- | -- | -- |
| model_name | name of the BigQuery ML model that you're creating or replacing |
| model_type | Specifies the model type. If the user sets the parameter `select_target_type` to numerical then model_type = AUTOML_REGRESSOR. If parameter set to categorical then model_type = AUTOML_CLASSIFIER  |
| input_label_cols | The label column name in the training data as specified by user with the parameter `select target` |
| budget_hours | Sets the training budget for AutoML Tables training, specified in hours. Defaults to 1.0 and must be between 1.0 and 72.0. | 1 |

Note the parameter `select features` allows the user to identify the columns to be used to predict the target and defines the model's training data. For more information about the options for the AutoML Tables Model like optimization objective or data split column, see the [Create Model Syntax documentation](https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-create-automl#create_model_syntax).

# Customizations
>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i> Note, AutoML Explores can be customized to include other model types, options and parameters. </font></b> If you would like to use a different machine learning model type or include other model parameters like modeling optimization objective, training/validation sets, or target probability thresholds, contact your Looker account team for guidance.
>



## Enabling Business Users

This block comes with a [Quick Start Guide for Business Users](https://github.com/looker/block-bqml-automl/blob/master/QUICK_START_GUIDE.md) and the following example Explore for enabling business users.
- AutoML Tables: Census Income Prediction


## Resources

[AutoML Tables Beginner's Guide](https://cloud.google.com/automl-tables/docs/beginners-guide)

[BigQuery ML Documentation](https://cloud.google.com/bigquery-ml/docs)

[BigQuery ML Pricing](https://cloud.google.com/bigquery-ml/pricing#bqml)

[BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations)


### Find an error or have suggestions for improvements?
Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommendations, simply create a "New Issue" in the corresponding Github repo for this Block. Please be as detailed as possible in your explanation, and we'll address it as quickly as we can.


#### Author: Google
