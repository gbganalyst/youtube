age <- floor(runif(6000, 18, 61))

gender <- sample(c("Male", "Female"), 6000, replace = T)

bmi <- round(runif(6000, 27.9, 36.8), 2)

children <- sample(x = c(0: 6),size =  6000, replace = T)

smoker <- sample(c("Yes", "No"), 6000, replace = T)

regions <- sample(c("Addis Ababa", "Afar", "Amhara", "Benishangul-Gumuz", "Dire Dawa", "Gambela", "Harari", "Oromia", "Sidama", "Somali", "Southern Nations", "Tigray", "Benishangul-Gumuz", "Oromia", "Dire Dawa", "Afar", "Gambela", "Harari", "Afar", "Amhara"), 6000, replace = T)

charges <- runif(6000, 146, 1536)
  
medical_cost <- tibble(age,	sex,	bmi,	children,	smoker,	regions,	charges)
 
medical_cost %>% write_csv("medical_cost.csv")
