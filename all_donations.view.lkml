view: all_donations {
  derived_table: {
    sql: (SELECT
      all_donations_1.amount  AS amount,
      all_donations_1.comment  AS comment,
      all_donations_1.donor_id  AS donor_id,
      all_donations_1.event  AS event,
      all_donations_1.name  AS name,
      all_donations_1.id  AS id,
      all_donations_1.time_received AS time_received
    FROM agdq2016.all_donations_1  AS all_donations_1)
    UNION DISTINCT
    (SELECT
      all_donations_2.amount  AS amount,
      all_donations_2.comment  AS comment,
      all_donations_2.donor_id  AS donor_id,
      all_donations_2.event  AS event,
      all_donations_2.name  AS name,
      all_donations_2.id  AS id,
      all_donations_2.time_received AS time_received
    FROM agdq2016.all_donations_2  AS all_donations_2);;
    datagroup_trigger: test_datagroup
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
    value_format_name: usd
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: donor_id {
    type: number
    sql: ${TABLE}.donor_id ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension_group: time_received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      time_of_day,
      hour_of_day,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time_received ;;
  }

  dimension: hours_since_start {
    type: number
    sql: TIMESTAMP_DIFF(${time_received_raw}, ${all_events.event_start_raw}, hour) ;;
  }

#   dimension: day_of_week_and_time {
#     type:  string
#     sql: CONCAT(${time_received_day_of_week}, ${time_received_hour_of_day}) ;;
#   }

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  measure: total_amount_donated {
    type: sum
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: cumulative_amount_donated {
    type: running_total
    sql: ${total_amount_donated} ;;
    value_format_name: usd
  }

  measure: avg_amount_donated {
    type: average
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: largest_donation {
    type: max
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: earliest_time {
    type: date_raw
    sql: MIN(${time_received_raw}) ;;
  }

  measure: latest_time {
    type: date_raw
    sql: MAX(${time_received_raw}) ;;
  }

  measure: number_of_donors {
    type: count_distinct
    sql: ${donor_id} ;;
  }

  measure: cumulative_number_of_donors {
    type: running_total
    sql: ${number_of_donors} ;;
  }


}
