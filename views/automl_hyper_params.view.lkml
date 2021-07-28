view: automl_hyper_params {
  label: "[4] AutoML: Set Model Parameters"

  parameter: set_budget_hours {
    label: "Set Budget Hours (optional)"
    description: "Sets the training budget for AutoML Tables training, specified in hours. Defaults to 1.0 and must be between 1.0 and 72.0."
    type: number
    default_value: "1.0"
  }
}
