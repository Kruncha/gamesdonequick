view: all_bids {
  sql_table_name: agdq2016.all_bids ;;

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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: goal {
    type: number
    sql: CASE WHEN ${TABLE}.goal = "(None)" THEN null ELSE ${TABLE}.goal END;;
    value_format_name: usd
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: run {
    type: string
    sql: ${TABLE}.run ;;
  }

  dimension: run_id {
    type: number
    sql: ${TABLE}.run_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  measure: total_amount_donated {
    type: sum
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: avg_amount_donated {
    type: average
    sql: ${amount} ;;
    value_format_name: usd
  }

}
