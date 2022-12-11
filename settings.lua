data:extend(
  {
    {
      type = "int-setting",
      name = "ufb-web-port",
      setting_type = "startup",
      default_value = 8082,
      minimum_value = 1000, 
      maximum_value = 10000,
    },
    {
        type = "int-setting",
        name = "ufb-web-refresh-time",
        setting_type = "startup",
        default_value = 120,
        minimum_value = 60, 
        maximum_value = 300,
      },
  }
)