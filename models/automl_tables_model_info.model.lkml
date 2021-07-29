connection: "@{CONNECTION_NAME}"

include: "/views/model_info.view"

explore: model_info {
  group_label: "Looker + BigQuery ML"
  label: "AutoML Tables: Model Info"
  description: "View all AutoML models created with Looker"
  persist_for: "0 minutes"
}
