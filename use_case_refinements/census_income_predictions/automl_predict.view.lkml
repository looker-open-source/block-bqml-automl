include: "/views/automl_predict.view.lkml"

view: +automl_predict {

  dimension: id {
    primary_key: yes
    type: number
  }
}
