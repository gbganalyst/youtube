install.load::install_load(c("tidyverse", "rio"))

data = import("Somalia contraceptive method choice.xlsx")

data %>% slice_sample(n=5000, replace = TRUE, weight_by = children) %>% 
  export("Somalia contraceptive method choice.csv")
