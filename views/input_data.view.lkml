view: input_data {
  label: "[1] AutoML: Input Data"

  derived_table: {
    sql:  SELECT CAST(CONCAT(age
                    , workclass
                    , functional_weight
                    , education
                    , education_num
                    , marital_status
                    , occupation
                    , relationship
                    , race
                    , sex
                    , capital_gain
                    , capital_loss
                    , hours_per_week
                    , native_country
                    , income_bracket
                    ) AS BYTES) AS id, * EXCEPT(row_count)
        FROM (SELECT age
                  , workclass
                  , functional_weight
                  , education
                  , education_num
                  , marital_status
                  , occupation
                  , relationship
                  , race
                  , sex
                  , capital_gain
                  , capital_loss
                  , hours_per_week
                  , native_country
                  , income_bracket
                  , COUNT(*) as row_count
              FROM `bigquery-public-data.ml_datasets.census_adult_income`
              GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
              HAVING row_count = 1
              )
  ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: workclass {
    type: string
    sql: ${TABLE}.workclass ;;
  }

  dimension: functional_weight {
    type: number
    sql: ${TABLE}.functional_weight ;;
  }

  dimension: education {
    type: string
    sql: ${TABLE}.education ;;
  }

  dimension: education_num {
    type: number
    sql: ${TABLE}.education_num ;;
  }

  dimension: marital_status {
    type: string
    sql: ${TABLE}.marital_status ;;
  }

  dimension: occupation {
    type: string
    sql: ${TABLE}.occupation ;;
  }

  dimension: relationship {
    type: string
    sql: ${TABLE}.relationship ;;
  }

  dimension: race {
    type: string
    sql: ${TABLE}.race ;;
  }

  dimension: sex {
    type: string
    sql: ${TABLE}.sex ;;
  }

  dimension: capital_gain {
    type: number
    sql: ${TABLE}.capital_gain ;;
  }

  dimension: capital_loss {
    type: number
    sql: ${TABLE}.capital_loss ;;
  }

  dimension: hours_per_week {
    type: number
    sql: ${TABLE}.hours_per_week ;;
  }

  dimension: native_country {
    type: string
    sql: ${TABLE}.native_country ;;
  }

  dimension: income_bracket {
    type: string
    sql: ${TABLE}.income_bracket ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      age,
      workclass,
      functional_weight,
      education,
      education_num,
      marital_status,
      occupation,
      relationship,
      race,
      sex,
      capital_gain,
      capital_loss,
      hours_per_week,
      native_country,
      income_bracket
    ]
  }
}
