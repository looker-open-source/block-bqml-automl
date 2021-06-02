include: "/views/automl_predict.view.lkml"

view: +automl_predict {

  dimension: ga_sessions_id {
    label: "Visitor ID"
    primary_key: yes
    type: string
  }
}
