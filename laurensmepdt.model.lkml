connection: "thelook"

# include all the views
include: "*.view"

datagroup: laurensmepdt_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: laurensmepdt_default_datagroup
