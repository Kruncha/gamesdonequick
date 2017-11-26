view: all_events {
  derived_table: {
    persist_for: "24 hours"
    sql: SELECT
      all_donations.event  AS all_donations_event,
      COUNT(DISTINCT all_runs.id ) AS all_runs_count,
      MIN(all_runs.start_time)  AS all_runs_earliest_run_start,
      MAX(all_runs.end_time)  AS all_runs_last_run_finish
    FROM `games-done-quick-analysis.agdq2016.LR_DFSO0NX55JZNCQAK04IMC_all_donations` AS all_donations
    INNER JOIN agdq2016.all_runs  AS all_runs ON all_donations.time_received > all_runs.start_time
          AND all_donations.time_received < all_runs.end_time
    GROUP BY 1 ;;
  }

  dimension: name {
    primary_key: yes
    type: string
    sql: ${TABLE}.all_donations_event ;;
  }

  dimension: number_of_runs {
    type: number
    sql: ${TABLE}.all_runs_count ;;
  }

  dimension_group: event_start {
    type: time
    sql: ${TABLE}.all_runs_earliest_run_start ;;
  }

  dimension_group: event_end {
    type: time
    sql: ${TABLE}.all_runs_last_run_finish ;;
  }
}
