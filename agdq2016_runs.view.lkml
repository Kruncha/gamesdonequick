view: agdq2016_runs {
  sql_table_name: agdq2016.agdq2016_runs ;;

  filter: test_filter {
    label: "My templated filter"
    type: string
    suggest_explore: agdq2016_donations
    suggest_dimension: agdq2016_runs.name
    default_value: "Agdq Pre-Show"
  }

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

  dimension_group: end_time {
    type: time
    sql: TIMESTAMP(${TABLE}.end_time) ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: players {
    type: string
    sql: ${TABLE}.players ;;
  }

  dimension_group: start_time {
    type: time
    sql: TIMESTAMP(${TABLE}.start_time) ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
