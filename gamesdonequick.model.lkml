#Testing git branches

connection: "agdq2016"
week_start_day: sunday

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

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
  persist_for: "24 hours"
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
