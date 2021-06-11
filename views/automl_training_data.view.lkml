include: "/explores/field_suggestions.explore"

view: automl_training_data {
  label: "[3] AutoML: Select Training Data"

  parameter: select_target {
    label: "Select Target (REQUIRED)"
    description: "Choose the field that you want to predict"
    type: unquoted
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }

  parameter: select_target_type {
    label: "Select Target Type (REQUIRED)"
    description: "Specify the type of data in your target field"
    type: unquoted
    allowed_value: {
      label: "Numerical"
      value: "numerical"
    }
    allowed_value: {
      label: "Categorical"
      value: "categorical"
    }
  }

  filter: select_features {
    label: "Select Features (REQUIRED)"
    description: "Choose relevant fields that will help your model predict its target"
    type: string
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }
}
