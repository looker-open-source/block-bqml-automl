include: "/views/model_info.view"

explore: model_name_suggestions {
  sql_always_where: ${model_info.explore} = 'census_income_predictions' ;;
  view_name: model_info
  hidden: yes
  persist_for: "0 minutes"
}
