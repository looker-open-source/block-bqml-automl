include: "/views/automl_predict.view.lkml"

include: "/use_case_refinements/nyc_taxi_predictions/input_data.view.lkml"

view: +automl_predict {
  extends: [input_data]
}
