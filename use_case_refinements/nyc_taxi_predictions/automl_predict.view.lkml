include: "/views/automl_predict.view.lkml"

view: +automl_predict {

  dimension: trip_id {
    label: "Trip ID"
    primary_key: yes
    type: string
  }
}
