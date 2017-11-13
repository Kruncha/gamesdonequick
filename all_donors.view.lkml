view: all_donors {
  derived_table: {
    persist_for: "24 hours"
    sql: SELECT
      all_donations.donor_id  AS all_donations_donor_id,
      COUNT(*) AS all_donations_count,
      COALESCE(SUM(all_donations.amount ), 0) AS all_donations_total_amount_donated,
      MAX(all_donations.amount ) AS all_donations_largest_donation,
      AVG(all_donations.amount ) AS all_donations_avg_amount_donated
    FROM ${all_donations.SQL_TABLE_NAME} AS all_donations

    GROUP BY 1 ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.all_donations_donor_id ;;
  }

  dimension: number_of_donations {
    type: number
    sql: ${TABLE}.all_donations_count ;;
  }

  dimension: amount_donated {
    type: number
    sql: ${TABLE}.all_donations_total_amount_donated ;;
  }

#   dimension: amount_donated_tier {
#     type: tier
#     sql: ${amount_donated} ;;
#     tiers: [1,2,5,10,20,50,]
#   }

  dimension: largest_donation {
    type: number
    sql: ${TABLE}.all_donations_largest_donation ;;
  }

  dimension: avg_donation_amount {
    type: number
    sql: ${TABLE}.all_donations_avg_amount_donated ;;
  }



}
