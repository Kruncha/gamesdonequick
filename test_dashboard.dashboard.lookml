- dashboard: gdq_donations
  title: GDQ Donations
  layout: newspaper
  query_timezone: UTC
  embed_style:
    background_color: "#ffffff"
    show_title: false
    title_color: "#ff0000"
    show_filters_bar: false
    tile_background_color: "#000000"
    tile_text_color: "#ffff00"
  elements:
  - name: Comment Length Donation Amount Correlation
    title: Comment Length Donation Amount Correlation
    model: gamesdonequick
    explore: agdq2016_donations
    type: looker_scatter
    fields:
    - agdq2016_donations.comment
    - agdq2016_donations.comment_length
    - agdq2016_donations.amount_donated
    filters:
      agdq2016_donations.amount_donated: "<500"
      agdq2016_donations.comment: "-NULL"
      agdq2016_donations.time_donated_hour: 2016/01/03 00:00 to 2016/01/10 23:59
    sorts:
    - agdq2016_donations.comment
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    series_types: {}
    hidden_fields:
    - agdq2016_donations.comment
    row:
    col:
    width:
    height:
  - name: Donation Total by Hour
    title: Donation Total by Hour
    model: gamesdonequick
    explore: agdq2016_donations
    type: looker_area
    fields:
    - agdq2016_donations.time_donated_hour
    - agdq2016_donations.total_amount_donated
    fill_fields:
    - agdq2016_donations.time_donated_hour
    filters:
      agdq2016_donations.time_donated_hour: 2016/01/03 00:00 to 2016/01/10 23:59
    sorts:
    - agdq2016_donations.time_donated_hour desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row:
    col:
    width:
    height:
  - name: Top 10 Runs by Donation Total
    title: Top 10 Runs by Donation Total
    model: gamesdonequick
    explore: agdq2016_donations
    type: looker_column
    fields:
    - agdq2016_donations.run_during_donated
    - agdq2016_donations.total_amount_donated
    sorts:
    - agdq2016_donations.total_amount_donated desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    interpolation: linear
    series_types: {}
    hidden_fields: []
    row:
    col:
    width:
    height:
  - name: Top Ten Donors by Total Donations
    title: Top Ten Donors by Total Donations
    model: gamesdonequick
    explore: agdq2016_donations
    type: looker_column
    fields:
    - agdq2016_donations.total_amount_donated
    - agdq2016_donations.donor
    filters:
      agdq2016_donations.donor: "-(Anonymous)"
    sorts:
    - agdq2016_donations.total_amount_donated desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    interpolation: linear
    series_types: {}
    hidden_fields: []
    row:
    col:
    width:
    height:
  - name: Donation Total and Donation Count by Hour
    title: Donation Total and Donation Count by Hour
    model: gamesdonequick
    explore: agdq2016_donations
    type: looker_line
    fields:
    - agdq2016_donations.time_donated_hour
    - agdq2016_donations.total_amount_donated
    - agdq2016_donations.count
    fill_fields:
    - agdq2016_donations.time_donated_hour
    filters:
      agdq2016_donations.time_donated_hour: 2016/01/03 00:00 to 2016/01/10 23:59
    sorts:
    - agdq2016_donations.time_donated_hour desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: agdq2016_donations.total_amount_donated
        name: Agdq2016_donations Total Amount Donated
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: agdq2016_donations.count
        name: Agdq2016_donations Count
    series_types: {}
    row:
    col:
    width:
    height:

    ########
