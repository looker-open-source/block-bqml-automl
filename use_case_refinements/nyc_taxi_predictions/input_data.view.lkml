include: "/views/input_data.view"

view: +input_data {
  derived_table: {
    sql:  SELECT ROW_NUMBER() OVER() as pk, *
          FROM `nyc-tlc.yellow.trips`
          WHERE ABS(MOD(FARM_FINGERPRINT(CAST(pickup_datetime AS STRING)), 100000)) = 1
          AND
            trip_distance > 0
            AND fare_amount >= 2.5 AND fare_amount <= 100.0
            AND pickup_longitude > -78
            AND pickup_longitude < -70
            AND dropoff_longitude > -78
            AND dropoff_longitude < -70
            AND pickup_latitude > 37
            AND pickup_latitude < 45
            AND dropoff_latitude > 37
            AND dropoff_latitude < 45
            AND passenger_count > 0
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: number
  }

  dimension: vendor_id {
    type: string
    sql: ${TABLE}.vendor_id ;;
  }

  dimension_group: pickup_datetime {
    type: time
    sql: ${TABLE}.pickup_datetime ;;
  }

  dimension_group: dropoff_datetime {
    type: time
    sql: ${TABLE}.dropoff_datetime ;;
  }

  dimension: pickup_longitude {
    type: number
    sql: ${TABLE}.pickup_longitude ;;
  }

  dimension: pickup_latitude {
    type: number
    sql: ${TABLE}.pickup_latitude ;;
  }

  dimension: dropoff_longitude {
    type: number
    sql: ${TABLE}.dropoff_longitude ;;
  }

  dimension: dropoff_latitude {
    type: number
    sql: ${TABLE}.dropoff_latitude ;;
  }

  dimension: rate_code {
    type: string
    sql: ${TABLE}.rate_code ;;
  }

  dimension: passenger_count {
    type: number
    sql: ${TABLE}.passenger_count ;;
  }

  dimension: trip_distance {
    type: number
    sql: ${TABLE}.trip_distance ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.payment_type ;;
  }

  dimension: fare_amount {
    type: number
    sql: ${TABLE}.fare_amount ;;
  }

  dimension: extra {
    type: number
    sql: ${TABLE}.extra ;;
  }

  dimension: mta_tax {
    label: "MTA Tax"
    type: number
    sql: ${TABLE}.mta_tax ;;
  }

  dimension: imp_surcharge {
    type: number
    sql: ${TABLE}.imp_surcharge ;;
  }

  dimension: tip_amount {
    type: number
    sql: ${TABLE}.tip_amount ;;
  }

  dimension: tolls_amount {
    type: number
    sql: ${TABLE}.tolls_amount ;;
  }

  dimension: total_amount {
    type: number
    sql: ${TABLE}.total_amount ;;
  }

  dimension: store_and_fwd_flag {
    type: string
    sql: ${TABLE}.store_and_fwd_flag ;;
  }

  measure: count {
    type: count
  }
}
