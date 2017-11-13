view: all_runs {
  sql_table_name: agdq2016.all_runs ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: bid_wars {
    type: string
    sql: ${TABLE}.bid_wars ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_time ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: players {
    type: string
    sql: ${TABLE}.players ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension: run_length_in_minutes {
    type: number
    sql: TIMESTAMP_DIFF(${end_raw}, ${start_raw}, minute) ;;
  }

  dimension: run_length_tier {
    type: tier
    tiers: [30,60,120]
    sql: ${run_length_in_minutes} ;;
  }

  measure: total_run_length_in_minutes {
    type: sum
    sql: ${run_length_in_minutes} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  measure: avg_amount_donated_per_minute {
    type: number
    value_format_name: usd
    sql: ${all_donations.total_amount_donated} / ${total_run_length_in_minutes} ;;
    drill_fields: [id, name, event, run_length_in_minutes]
  }

  measure: earliest_run_start {
    type: date_raw
    sql: MIN(${start_raw}) ;;
  }

  measure: last_run_finish {
    type: date_raw
    sql: MAX(${end_raw}) ;;
  }

  measure: total_number_of_hours {
    type: number
    sql: TIMESTAMP_DIFF(${last_run_finish}, ${earliest_run_start}, hour) ;;
  }

  measure: cumulative_number_of_hours {
    type: running_total
    sql: ${total_number_of_hours} ;;
  }
}
