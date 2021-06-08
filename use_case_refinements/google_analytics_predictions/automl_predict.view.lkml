include: "/views/automl_predict.view.lkml"

view: +automl_predict {

  dimension: session_id {
    label: "Session ID"
    primary_key: yes
    type: string
  }
}
