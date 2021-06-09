include: "/views/automl_predict.view.lkml"

view: +automl_predict {

  dimension: row_number {
    primary_key: yes
    type: number
  }
}
