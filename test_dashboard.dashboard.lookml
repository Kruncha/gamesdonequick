- dashboard: analysis
  title: Analysis
  layout: newspaper
  elements:
  - title: Correlation Between Run Length and Donation Amount Per Minute
    name: Correlation Between Run Length and Donation Amount Per Minute
    model: gamesdonequick
    explore: all_donations
    type: looker_scatter
    fields:
    - all_runs.avg_amount_donated_per_minute
    - all_runs.id
    - all_runs.total_run_length_in_minutes
    filters:
      all_runs.avg_amount_donated_per_minute: "<2000"
    sorts:
    - all_runs.avg_amount_donated_per_minute desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_series:
    - all_runs.count
    series_types: {}
    hidden_fields:
    - all_runs.id
    trend_lines:
    - color: "#000000"
      label_position: right
      period: 7
      regression_type: linear
      series_index: 1
      show_label: true
      label_type: equation
    reference_lines: []
    row: 0
    col: 0
    width: 14
    height: 10
  - name: Donations by Country
    title: Donations by Country
    model: gamesdonequick
    explore: agdq2016
    type: looker_map
    fields:
    - agdq2016.country
    - agdq2016.count
    filters:
      agdq2016.country: "-NULL"
    sorts:
    - agdq2016.count desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: number_of_times_mentioned_log_scale
      label: Number of Times Mentioned (Log Scale)
      expression: log(${agdq2016.count})
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    hidden_fields:
    - agdq2016.count
    map_latitude: 57.231502991478926
    map_longitude: 359.12109375000006
    map_zoom: 2
    row: 10
    col: 10
    width: 14
    height: 9
  - name: What Percent of Donors Donate What Percent of the Money?
    title: What Percent of Donors Donate What Percent of the Money?
    model: gamesdonequick
    explore: all_donors
    type: looker_line
    fields:
    - all_donors.total_amount_donated
    - all_donors.amount_donated_percentile
    filters:
      all_donors.id: not 0
    sorts:
    - all_donors.total_amount_donated desc 0
    - all_donors.amount_donated_percentile
    limit: 500
    total: true
    dynamic_fields:
    - table_calculation: percent_of_total_donations
      label: Percent of Total Donations
      expression: sum(offset_list(${all_donors.total_amount_donated}, 1 - row(), row()))
        / ${all_donors.total_amount_donated:total}
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields:
    - all_donors.total_amount_donated
    row: 10
    col: 0
    width: 10
    height: 9
