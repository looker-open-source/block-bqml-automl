include: "/views/input_data.view"

view: +input_data {
  derived_table: {
    sql: SELECT
          CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  AS ga_sessions_id,
              (CASE WHEN ga_sessions.visitnumber = 1  THEN 'Yes' ELSE 'No' END) AS ga_sessions_first_time_visitor,
          ga_sessions.visitnumber AS ga_sessions_visitnumber,
          device.browser AS device_browser,
          CASE
                WHEN device.isMobile then 'Mobile'
                ELSE 'Desktop'
              END AS device_device_type_1,
          device.isMobile AS device_ismobile_1,
          hits_social.socialNetwork AS hits_social_socialnetwork_1,
          ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( totals.pageviews  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS totals_pageviews_total,
          ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( totals.timeonsite  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( ( CONCAT(CAST(ga_sessions.fullVisitorId AS STRING), '|', COALESCE(CAST(ga_sessions.visitId AS STRING),''))  )   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS totals_timeonsite_total
      FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`  AS ga_sessions
      LEFT JOIN UNNEST([ga_sessions.totals]) as totals
      LEFT JOIN UNNEST([ga_sessions.device]) as device
      LEFT JOIN UNNEST(ga_sessions.hits) as hits
      LEFT JOIN UNNEST([hits.social]) as hits_social
      GROUP BY
          1,
          2,
          3,
          4,
          5,
          6,
          7
      ORDER BY
          1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ga_sessions_id {
    type: string
    sql: ${TABLE}.ga_sessions_id ;;
  }

  dimension: ga_sessions_first_time_visitor {
    type: string
    sql: ${TABLE}.ga_sessions_first_time_visitor ;;
  }

  dimension: is_repeat_visitor {
    type: yesno
    sql: ${ga_sessions_visitnumber} > 1 ;;
  }



  dimension: ga_sessions_visitnumber {
    type: number
    sql: ${TABLE}.ga_sessions_visitnumber ;;
  }

  dimension: device_browser {
    type: string
    sql: ${TABLE}.device_browser ;;
  }

  dimension: device_device_type_1 {
    type: string
    sql: ${TABLE}.device_device_type_1 ;;
  }

  dimension: device_ismobile_1 {
    type: string
    sql: ${TABLE}.device_ismobile_1 ;;
  }

  dimension: hits_social_socialnetwork_1 {
    type: string
    sql: ${TABLE}.hits_social_socialnetwork_1 ;;
  }

  dimension: totals_pageviews_total {
    type: number
    sql: ${TABLE}.totals_pageviews_total ;;
  }

  dimension: totals_timeonsite_total {
    type: number
    sql: ${TABLE}.totals_timeonsite_total ;;
  }

  set: detail {
    fields: [
      ga_sessions_id,
      ga_sessions_first_time_visitor,
      ga_sessions_visitnumber,
      device_browser,
      device_device_type_1,
      device_ismobile_1,
      hits_social_socialnetwork_1,
      totals_pageviews_total,
      totals_timeonsite_total
    ]
  }

}
