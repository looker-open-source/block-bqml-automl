include: "/views/input_data.view"

view: +input_data {
  derived_table: {
    sql: SELECT CONCAT(ga_sessions.fullVisitorId, '|', ga_sessions.visitId) AS session_id
      , ga_sessions.fullVisitorId AS full_visitor_id
      , ga_sessions.visitId AS visit_id
      , ga_sessions.visitnumber AS visit_number
      , (CASE
          WHEN ga_sessions.visitnumber = 1 THEN 'Yes'
          ELSE 'No'
        END) AS first_time_visitor
      , SUM(totals.pageviews) AS total_page_views
      , SUM(totals.timeonsite) AS total_time_on_site
      , SUM(totals.hits) AS total_hits
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` AS ga_sessions
    LEFT JOIN UNNEST([ga_sessions.totals]) as totals
    GROUP BY 1,2,3,4,5
     ;;
  }

  dimension: session_id {
    label: "Session ID"
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.full_visitor_id ;;
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visit_id ;;
  }

  dimension: visit_number {
    type: number
    sql: ${TABLE}.visit_number ;;
  }

  dimension: first_time_visitor {
    type: string
    sql: ${TABLE}.first_time_visitor ;;
  }

  dimension: total_page_views {
    type: number
    sql: ${TABLE}.total_page_views ;;
  }

  dimension: total_time_on_site {
    type: number
    sql: ${TABLE}.total_time_on_site ;;
  }

  dimension: total_hits {
    type: number
    sql: ${TABLE}.total_hits ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      session_id,
      full_visitor_id,
      visit_id,
      visit_number,
      first_time_visitor,
      total_page_views,
      total_time_on_site,
      total_hits
    ]
  }
}
