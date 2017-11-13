view: agdq2016 {
  sql_table_name: agdq2016.agdq2016 ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: amount_donated {
    type: number
    value_format_name: usd_0
    sql: ${TABLE}.amount_donated ;;
  }

  dimension: bid_category {
    order_by_field: count
    type: string
    sql: ${TABLE}.bid_category ;;
  }

  measure: min_date_donated {
    type: min
    sql: ${time_donated_date} ;;
  }

  dimension: bid_choice {
    type: string
    sql: ${TABLE}.bid_choice ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: country {
    map_layer_name: countries
    order_by_field: count
    sql: ARRAY(SELECT x FROM UNNEST(SPLIT("Afghanistan,Angola,Albania,United Arab Emirates,Argentina,Armenia,Antarctica,French Southern and Antarctic Lands,Australia,Austria,Azerbaijan,Burundi,Belgium,Benin,Burkina Faso,Bangladesh,Bulgaria,The Bahamas,Bosnia and Herzegovina,Belarus,Belize,Bolivia,Brazil,Brunei,Bhutan,Botswana,Central African Republic,Canada,Switzerland,Chile,China,Ivory Coast,Cameroon,Democratic Republic of the Congo,Republic of the Congo,Colombia,Costa Rica,Cuba,Northern Cyprus,Cyprus,Czech Republic,Germany,Djibouti,Denmark,Dominican Republic,Algeria,Ecuador,Egypt,Eritrea,Spain,Estonia,Ethiopia,Finland,Fiji,Falkland Islands,France,Gabon,United Kingdom,Georgia,Ghana,Guinea,Gambia,Guinea Bissau,Equatorial Guinea,Greece,Greenland,Guatemala,Guyana,Honduras,Croatia,Haiti,Hungary,Indonesia,India,Ireland,Iran,Iraq,Iceland,Israel,Italy,Jamaica,Jordan,Japan,Kazakhstan,Kenya,Kyrgyzstan,Cambodia,South Korea,Kosovo,Kuwait,Laos,Lebanon,Liberia,Libya,Sri Lanka,Lesotho,Lithuania,Luxembourg,Latvia,Morocco,Moldova,Madagascar,Mexico,Macedonia,Mali,Myanmar,Montenegro,Mongolia,Mozambique,Mauritania,Malawi,Malaysia,Namibia,New Caledonia,Niger,Nigeria,Nicaragua,Netherlands,Norway,Nepal,New Zealand,Oman,Pakistan,Panama,Peru,Philippines,Papua New Guinea,Poland,Puerto Rico,North Korea,Portugal,Paraguay,Qatar,Romania,Russia,Rwanda,Western Sahara,Saudi Arabia,Sudan,South Sudan,Senegal,Solomon Islands,Sierra Leone,El Salvador,Somaliland,Somalia,Republic of Serbia,Suriname,Slovakia,Slovenia,Sweden,Swaziland,Syria,Chad,Togo,Thailand,Tajikistan,Turkmenistan,East Timor,Trinidad and Tobago,Tunisia,Turkey,Taiwan,United Republic of Tanzania,Uganda,Ukraine,Uruguay,United States of America,Uzbekistan,Venezuela,Vietnam,Vanuatu,West Bank,Yemen,South Africa,Zambia,Zimbabwe", ",")) AS x
      WHERE REGEXP_CONTAINS(${comment}, x))[SAFE_ORDINAL(1)];;
  }

  dimension: country2 {
    sql: ${comment} ;;
    html: {% assign list_of_countries = 'Afghanistan,Angola,Albania,United Arab Emirates,Argentina,Armenia,Antarctica,French Southern and Antarctic Lands,Australia,Austria,Azerbaijan,Burundi,Belgium,Benin,Burkina Faso,Bangladesh,Bulgaria,The Bahamas,Bosnia and Herzegovina,Belarus,Belize,Bolivia,Brazil,Brunei,Bhutan,Botswana,Central African Republic,Canada,Switzerland,Chile,China,Ivory Coast,Cameroon,Democratic Republic of the Congo,Republic of the Congo,Colombia,Costa Rica,Cuba,Northern Cyprus,Cyprus,Czech Republic,Germany,Djibouti,Denmark,Dominican Republic,Algeria,Ecuador,Egypt,Eritrea,Spain,Estonia,Ethiopia,Finland,Fiji,Falkland Islands,France,Gabon,United Kingdom,Georgia,Ghana,Guinea,Gambia,Guinea Bissau,Equatorial Guinea,Greece,Greenland,Guatemala,Guyana,Honduras,Croatia,Haiti,Hungary,Indonesia,India,Ireland,Iran,Iraq,Iceland,Israel,Italy,Jamaica,Jordan,Japan,Kazakhstan,Kenya,Kyrgyzstan,Cambodia,South Korea,Kosovo,Kuwait,Laos,Lebanon,Liberia,Libya,Sri Lanka,Lesotho,Lithuania,Luxembourg,Latvia,Morocco,Moldova,Madagascar,Mexico,Macedonia,Mali,Myanmar,Montenegro,Mongolia,Mozambique,Mauritania,Malawi,Malaysia,Namibia,New Caledonia,Niger,Nigeria,Nicaragua,Netherlands,Norway,Nepal,New Zealand,Oman,Pakistan,Panama,Peru,Philippines,Papua New Guinea,Poland,Puerto Rico,North Korea,Portugal,Paraguay,Qatar,Romania,Russia,Rwanda,Western Sahara,Saudi Arabia,Sudan,South Sudan,Senegal,Solomon Islands,Sierra Leone,El Salvador,Somaliland,Somalia,Republic of Serbia,Suriname,Slovakia,Slovenia,Sweden,Swaziland,Syria,Chad,Togo,Thailand,Tajikistan,Turkmenistan,East Timor,Trinidad and Tobago,Tunisia,Turkey,Taiwan,United Republic of Tanzania,Uganda,Ukraine,Uruguay,United States of America,Uzbekistan,Venezuela,Vietnam,Vanuatu,West Bank,Yemen,South Africa,Zambia,Zimbabwe' | split: ',' %}
            {% for country in list_of_countries %}
              {% if value contains country %}
                {{country}}
                {% break %}
              {% endif %}
            {% endfor %}
          ;;
  }


  dimension: donor {
    type: string
    sql: ${TABLE}.donor ;;
  }

  dimension: donor_id {
    type: string
    sql: ${TABLE}.donor_id ;;
  }

  dimension: run_during_donated {
    sql: ${TABLE}.run_during_donated ;;
    html:
      {% if value contains 'Any%' %}
      <p style="color: black; width: 50; background-color: lightblue; font-size:100%; text-align:center"><img src="https://m.youtube.com/yts/mobile/img/apple-touch-icon-144x144-precomposed-vflwq-hLZ.png" /><a href="https://www.youtube.com/results?search_query=gdq+{{ value }}" target="_new">{{ rendered_value }}</a></p>
      {% elsif value contains '100%' %}
      <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center"><img src="https://m.youtube.com/yts/mobile/img/apple-touch-icon-144x144-precomposed-vflwq-hLZ.png" /><a href="https://www.youtube.com/results?search_query=gdq+{{ value }}" target="_new">{{ rendered_value }}</a></p>
      {% else %}
      <p style="color: black; background-color: orange; font-size:100%; text-align:center"><img src="https://m.youtube.com/yts/mobile/img/apple-touch-icon-144x144-precomposed-vflwq-hLZ.png" /><a href="https://www.youtube.com/results?search_query=gdq+{{ value }}" target="_new">{{ rendered_value }}</a></p>
      {% endif %}
      ;;
    link: {
      label: "Youtube"
      url: "https://www.youtube.com/results?search_query=gdq+{{ value }}"
      icon_url: "https://m.youtube.com/yts/mobile/img/apple-touch-icon-144x144-precomposed-vflwq-hLZ.png"
    }
  }

  dimension: comment_length {
    type: number
    sql: LENGTH(${comment}) ;;
  }

  dimension_group: time_donated {
    type: time
    sql: TIMESTAMP(${TABLE}.time_donated) ;;
    timeframes: [raw, date, time, hour, hour_of_day, hour3, time_of_day]
  }

  dimension: formatted_time {
    type: string
    sql: FORMAT_TIME('%l:%M %p', TIME ${time_donated_raw}) ;;
  }

  dimension: tiered_time_of_day {
    type: tier
    sql: ${time_donated_hour_of_day} ;;
    tiers: [0,3,6,9,12,15,18,21]
    order_by_field: count
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  measure: total_amount_donated {
    type: sum
    sql: ${amount_donated} ;;
  }

  measure: avg_amount_donated {
    type: average
    sql: ${amount_donated} ;;
  }

  measure: earliest_time {
    type: date_time
    sql: MIN(${time_donated_raw}) ;;
    convert_tz: no
  }

  measure: latest_time {
    type: date_time
    sql: MAX(${time_donated_raw}) ;;
    convert_tz: no
  }

  measure: avg_amount_donated_per_minute {
    type: sum
    filters: {
      field: time_donated_time
      value: "2016/01/03 for 7 days"
    }
    sql: ${amount_donated} / DATETIME_DIFF(DATETIME(MAX(${time_donated_raw})), DATETIME(MIN(${time_donated_raw})), minute) ;;
  }
}

#     html: {{ rendered_value }} || {{ total_amount_donated._rendered_value }};;
