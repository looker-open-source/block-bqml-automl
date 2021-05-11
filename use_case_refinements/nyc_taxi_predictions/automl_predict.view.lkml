include: "/views/automl_predict.view.lkml"

view: +automl_predict {

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: number
  }
}
