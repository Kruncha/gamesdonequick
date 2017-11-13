view: all_prizes {
  sql_table_name: agdq2016.all_prizes ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: contributed_by {
    type: string
    sql: ${TABLE}.contributed_by ;;
  }

  dimension: end_game {
    type: number
    sql: ${TABLE}.end_game ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: image {
    type: string
    sql: ${TABLE}.image ;;
  }

  dimension: image_link {
    type: string
    sql: ${TABLE}.image_link ;;
  }

  dimension: minimum_bid {
    type: number
    sql: ${TABLE}.minimum_bid ;;
    value_format_name: usd
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: start_game {
    type: number
    sql: ${TABLE}.start_game ;;
  }

  dimension: winner_ids {
    type: string
    sql: ${TABLE}.winner_ids ;;
  }

  dimension: winner_names {
    type: string
    sql: ${TABLE}.winner_names ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
