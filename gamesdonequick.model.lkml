#Testing git branches

connection: "agdq2016"
week_start_day: sunday

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: test_datagroup {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "5 minutes"
}

persist_with: test_datagroup

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
# #
explore: agdq2016 {
  join: agdq2016_runs {
    type: inner
    relationship: many_to_many
    sql_on: {% condition agdq2016_runs.test_filter %} agdq2016_runs.name {% endcondition %}
    AND ${agdq2016.time_donated_raw} > ${agdq2016_runs.start_time_raw}
    AND ${agdq2016.time_donated_raw} < ${agdq2016_runs.end_time_raw}
    ;;
  }
}

explore: derived_table_with_temp_filter {}

explore: all_donations_1 {
  hidden:  yes
}

explore: all_donations_2 {
  hidden:  yes
}

explore: all_donors {}

explore: all_donations {
  join: all_events {
    type: inner
    relationship: many_to_one
    sql_on: ${all_donations.event} = ${all_events.name} ;;
  }
  join: all_runs {
    type: inner
    relationship: many_to_one
    sql_on: ${all_donations.time_received_raw} > ${all_runs.start_raw}
      AND ${all_donations.time_received_raw} < ${all_runs.end_raw} ;;
  }
  join: all_bids {
    type: left_outer
    relationship: one_to_many
    sql_on: ${all_runs.id} = ${all_bids.run_id} ;;
  }
  join: all_prizes {
    type: left_outer
    relationship: one_to_many
    sql_on: ${all_runs.id} = ${all_prizes.end_game_id};;
  }
  join: all_runs2 {
    from:  all_runs
    type: left_outer
    relationship: many_to_one
    sql_on: ${all_prizes.start_game_id} = ${all_runs2.id}  ;;
  }
}

view: all_donations {
  derived_table: {
    datagroup_trigger: test_datagroup
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
