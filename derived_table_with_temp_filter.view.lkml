view: derived_table_with_temp_filter {
  filter: test_filter {
    label: "test_filter"
    type: string
    suggest_explore: agdq2016_donations
    suggest_dimension: agdq2016_runs.name
    default_value: "Agdq Pre-Show"
  }
  derived_table: {
    sql: SELECT
      agdq2016_runs.name  AS agdq2016_runs_name,
      AVG(agdq2016_donations.amount_donated ) AS agdq2016_donations_avg_amount_donated,
      COUNT(*) AS agdq2016_donations_count,
      COALESCE(SUM(agdq2016_donations.amount_donated ), 0) AS agdq2016_donations_total_amount_donated
    FROM agdq2016.agdq2016  AS agdq2016_donations
    INNER JOIN agdq2016.agdq2016_runs  AS agdq2016_runs ON (TIMESTAMP(agdq2016_donations.time_donated)) > (TIMESTAMP(agdq2016_runs.start_time)) AND
        (TIMESTAMP(agdq2016_donations.time_donated)) < (TIMESTAMP(agdq2016_runs.end_time))
    WHERE {% condition test_filter %} agdq2016_runs.name {% endcondition %}

    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 500 ;;
  }

  dimension: agdq2016_runs_name {
    type: string
    sql: ${TABLE}.agdq2016_runs_name ;;
  }

  dimension: agdq2016_donations_avg_amount_donated {
    type: number
    sql: ${TABLE}.agdq2016_donations_avg_amount_donated ;;
  }

  dimension: agdq2016_donations_total_amount_donated {
    type: number
    sql: ${TABLE}.agdq2016_donations_total_amount_donated ;;
  }

  dimension: agdq2016_donations_count {
    type: number
    sql: ${TABLE}.agdq2016_donations_count ;;
  }
}
